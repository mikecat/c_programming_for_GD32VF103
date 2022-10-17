#define PORT16(addr) (*(volatile unsigned short*)(addr))
#define PORT32(addr) (*(volatile unsigned int*)(addr))
#define CLI() __asm__ __volatile__("csrrci zero, 0x300, 0x8")
#define STI() __asm__ __volatile__("csrrsi zero, 0x300, 0x8")

/*
PREDV0 input = HXTAL
PREDV0 = /1
PLL input = PREDV0
PLL = x12 (8MHz -> 96MHz)
CK_SYS = CK_PLL
USB prescaler = /2 (96MHz -> 48MHz)
AHB prescaler = /1
APB1 prescaler = /16 (96MHz -> 6MHz, TIMER1-6: 12MHz)
APB2 prescaler = /16 (96MHz -> 6MHz)
ADC prescaler = /8 (96MHz -> 12MHz)
*/
void initializeClock(void) {
	/* set RCU_CFG0 */
	PORT32(0x40021000 + 0x04) =
		(0 << 24) | /* CKOUT0 Clock Source = None */
		(3 << 22) | /* USBFS clock prescaler = /2 */
		(0 << 29) | (0xA << 18) | /* PLL = x12 */
		(0 << 17) | /* PREDV0 = /1 */
		(1 << 16) | /* PLL input = HXTAL */
		(0 << 28) | (3 << 14) | /* ADC prescaler = /8 */
		(7 << 11) | /* APB2 prescaler = /16 */
		(7 << 8) | /* APB1 prescaler = /16 */
		(0 << 4) | /* AHB prescaler = /1 */
		0; /* CK_SYS = CK_IRC8M */
	/* enable PLL and HXTAL */
	PORT32(0x40021000 + 0x00) |= (1 << 24) | (1 << 16);
	/* wait until PLL and HXTAL stable */
	while (~PORT32(0x40021000 + 0x00) & ((1 << 25) | (1 << 17)));
	/* set CK_SYS = CK_PLL */
	PORT32(0x40021000 + 0x04) |= 2;
	/* wait until CK_PLL is selected */
	while ((PORT32(0x40021000 + 0x04) & 0xC) != 0x8);
	/* disable IRC8M */
	PORT32(0x40021000 + 0x00) &= ~1;

	/* enable DMA0 clock */
	PORT32(0x40021000 + 0x14) |= 1 << 0;
	/* enable USART0 and PORTA clock */
	PORT32(0x40021000 + 0x18) |= (1 << 14) | (1 << 2);
}

/*
PA10 (UART0 RX) : input, weak pull-up
PA9 (UART0 TX) : AFIO output, 10MHz, push-pull
*/
void initializePort(void) {
	/* set GPIOA_CTL1 */
	PORT32(0x40010800 + 0x04) = (PORT32(0x40010800 + 0x04) & 0xfffff00f) | 0x890;
	/* set PA10 to HIGH (pull-up) via GPIOA_BOP */
	PORT32(0x40010800 + 0x10) = 1 << 10;
}

volatile unsigned char uart_tx_qs, uart_tx_qe;
volatile short uart_tx_dma_len;
unsigned char uart_tx_q[256];
volatile unsigned char uart_rx_qs, uart_rx_qe;
unsigned char uart_rx_q[256];

/*
UART0: 8 data bits, no pality, 9600bps
*/
void initializeUart(void) {
	/* USART_CTL0: enable RX interrupt, enable transmitter, enable receiver */
	PORT32(0x40013800 + 0x0C) = (1 << 5) | (1 << 3) | (1 << 2);
	/* USART_CTL2: enable transmission DMA request */
	PORT32(0x40013800 + 0x14) = 1 << 7;
	/* USART_BAUD */
	PORT32(0x40013800 + 0x08) = 6000000 / 9600;

	/* initialize DMA0 Channel 3 (USART0_TX) */
	/* DMA_CH3CTL */
	PORT32(0x40020000 + 0x08 + 0x14 * 3) =
		(2 << 8) | /* 32-bit access for peripheral */
		(1 << 7) | /* increase memory address */
		(1 << 4) | /* memory to peripheral */
		(1 << 1); /* enable full transfer finish interrupt */
	/* DMA_CH3PADDR = USART_DATA */
	PORT32(0x40020000 + 0x10 + 0x14 * 3) = 0x40013800 + 0x04;

	/* initialize variables */
	uart_tx_qs = 0;
	uart_tx_qe = 0;
	uart_tx_dma_len = 0;
	uart_rx_qs = 0;
	uart_rx_qe = 0;

	/* USART_CTL0: enable UART0 */
	PORT32(0x40013800 + 0x0C) |= 1 << 13;
}

void start_uart_tx_dma(void) {
	/* disable Channel 3 */
	PORT32(0x40020000 + 0x08 + 0x14 * 3) &= ~1;
	/* check if data exists in the queue */
	if (uart_tx_qs != uart_tx_qe) {
		int queue_data_end = uart_tx_qe < uart_tx_qs ? 256 : uart_tx_qe;
		uart_tx_dma_len = queue_data_end - uart_tx_qs;
		/* DMA_CH3MADDR */
		PORT32(0x40020000 + 0x14 + 0x14 * 3) = (unsigned int)uart_tx_q + uart_tx_qs;
		/* DMA_CH3CNT */
		PORT32(0x40020000 + 0x0C + 0x14 * 3) = uart_tx_dma_len;
		/* enable Channel 3 */
		PORT32(0x40020000 + 0x08 + 0x14 * 3) |= 1;
	} else {
		uart_tx_dma_len = 0;
	}
}

void _interrupt_handler_dma0_3(void) {
	/* check for Channel 3 full transfer finish flag */
	if (!(PORT32(0x40020000 + 0x00) & (1 << 13))) return;
	/* clear for Channel 3 flags */
	PORT32(0x40020000 + 0x04) = 1 << 12;
	/* dequeue data sent */
	uart_tx_qs += uart_tx_dma_len;
	/* start next transmission */
	start_uart_tx_dma();
}

void _interrupt_handler_usart0(void) {
	unsigned int status, data;
	status = PORT32(0x40013800 + 0x00);
	if (!(status & 0x2f)) return; /* check for received data or error */
	data = PORT32(0x40013800 + 0x04);
	/* check if data is received and no error is detected */
	if ((status & (1 << 5)) && !(status & 7)) {
		/* put received data if the buffer has a room */
		unsigned char uart_rx_qe_next = uart_rx_qe + 1; /* convert to unsigned char for wraparound */
		if (uart_rx_qe_next != uart_rx_qs) {
			uart_rx_q[uart_rx_qe] = data;
			uart_rx_qe = uart_rx_qe_next;
		}
	}
}

int uart_getchar(void) {
	int ret;
	while (uart_rx_qs == uart_rx_qe);
	ret = uart_rx_q[uart_rx_qs];
	uart_rx_qs++;
	return ret;
}

void uart_putchar(int c) {
	while ((unsigned char)(uart_tx_qe + 1) == uart_tx_qs);
	uart_tx_q[uart_tx_qe] = c;
	uart_tx_qe++;
	if (uart_tx_dma_len == 0) start_uart_tx_dma();
}

void uart_puts(const char* str) {
	while (*str) uart_putchar(*(str++));
	uart_putchar('\n');
}

int main(void) {
	initializeClock();
	initializePort();
	initializeUart();
	STI();

	uart_puts("hello, world!");

	for(;;) {
		int c = uart_getchar();
		uart_putchar(c + 1);
	}
}
