#define PORT16(addr) (*(volatile unsigned short*)(addr))
#define PORT32(addr) (*(volatile unsigned int*)(addr))

int status;

int main(void) {
	/* enable PORTA and PORTC */
	PORT32(0x40021000 + 0x18) |= 0x14;
	/* enable TIMER5 */
	PORT32(0x40021000 + 0x1C) |= 0x10;

	/* set PA1 and PA2 to output */
	PORT32(0x40010800 + 0x00) = (PORT32(0x40010800 + 0x00) & 0xfffff00f) | 0x220;
	/* set PC13 to output */
	PORT32(0x40011000 + 0x04) = (PORT32(0x40011000 + 0x04) & 0xff0fffff) | 0x200000;
	/* set PA1 and PA2 to HIGH */
	PORT32(0x40010800 + 0x10) = 6;
	/* set PC13 to HIGH */
	PORT32(0x40011000 + 0x10) = 1 << 13;

	/* disable TIMER5 */
	PORT16(0x40001000 + 0x00) = 0;
	/* clear TIMER5 interrupt */
	PORT16(0x40001000 + 0x10) = 0;
	/* enable TIMER5 interrupt */
	PORT16(0x40001000 + 0x0C) = 1;
	/* reset TIMER5 */
	PORT16(0x40001000 + 0x24) = 0;
	/* set TIMER5 prescaler */
	PORT16(0x40001000 + 0x28) = 1000;
	/* set TIMER5 max value */
	PORT16(0x40001000 + 0x2C) = 8000 - 1;
	/* enable TIMER5 */
	PORT16(0x40001000 + 0x00) = 1;

	/* enable global interrupt */
	__asm__ __volatile__("csrrsi zero, 0x300, 0x8");

	for(;;);
}

void _interrupt_handler_timer5(void) {
	/* check TIMER5 interrupt flag */
	if (!(PORT16(0x40001000 + 0x10) & 1)) return;
	/* clear TIMER5 interrupt flag */
	PORT16(0x40001000 + 0x10) = 0;

	status = (status + 1) & 0x7;
	/* R = status[0] */
	PORT32(0x40011000 + 0x10) = status & 1 ? 1 << 29 : 1 << 13;
	/* G = status[1], B = status[2] */
	PORT32(0x40010800 + 0x10) = (status & 2 ? 1 << 17 : 1 << 1) | (status & 4 ? 1 << 18 : 1 <<2);
}
