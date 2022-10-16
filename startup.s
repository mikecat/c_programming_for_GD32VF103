# licensed under CC0 1.0

.extern _init_data_src_start
.extern _init_data_dest_start
.extern _init_data_dest_end
.extern _bss_start
.extern _bss_end

.section .startup, "ax"
.global _start
_start:
	.option push
	.option norvc
	lui a5, %hi(start_code)
	addi a5, a5, %lo(start_code)
	jalr zero, a5
	.option pop

interrupt_vector_table:
	.long _interrupt_handler_clic_sft
	.long _interrupt_handler_4
	.long _interrupt_handler_5
	.long _interrupt_handler_6
	.long _interrupt_handler_clic_tmr
	.long _interrupt_handler_8
	.long _interrupt_handler_9
	.long _interrupt_handler_10
	.long _interrupt_handler_11
	.long _interrupt_handler_12
	.long _interrupt_handler_13
	.long _interrupt_handler_14
	.long _interrupt_handler_15
	.long _interrupt_handler_16
	.long _interrupt_handler_clic_bwei
	.long _interrupt_handler_clic_pmovi
	.long _interrupt_handler_wwdgt
	.long _interrupt_handler_lvd # 20
	.long _interrupt_handler_tamper
	.long _interrupt_handler_rtc
	.long _interrupt_handler_fmc
	.long _interrupt_handler_rcu
	.long _interrupt_handler_exti_0
	.long _interrupt_handler_exti_1
	.long _interrupt_handler_exti_2
	.long _interrupt_handler_exti_3
	.long _interrupt_handler_exti_4
	.long _interrupt_handler_dma0_0 # 30
	.long _interrupt_handler_dma0_1
	.long _interrupt_handler_dma0_2
	.long _interrupt_handler_dma0_3
	.long _interrupt_handler_dma0_4
	.long _interrupt_handler_dma0_5
	.long _interrupt_handler_dma0_6
	.long _interrupt_handler_adc
	.long _interrupt_handler_can0_tx
	.long _interrupt_handler_can0_rx0
	.long _interrupt_handler_can0_rx1 # 40
	.long _interrupt_handler_can0_ewmc
	.long _interrupt_handler_exti_5_9
	.long _interrupt_handler_timer0_break
	.long _interrupt_handler_timer0_update
	.long _interrupt_handler_timer0_trigger
	.long _interrupt_handler_timer0_compare
	.long _interrupt_handler_timer1
	.long _interrupt_handler_timer2
	.long _interrupt_handler_timer3
	.long _interrupt_handler_i2c0_event # 50
	.long _interrupt_handler_i2c0_error
	.long _interrupt_handler_i2c1_event
	.long _interrupt_handler_i2c1_error
	.long _interrupt_handler_spi0
	.long _interrupt_handler_spi1
	.long _interrupt_handler_usart0
	.long _interrupt_handler_usart1
	.long _interrupt_handler_usart2
	.long _interrupt_handler_exti_10_15
	.long _interrupt_handler_rtc_alarm # 60
	.long _interrupt_handler_usbfs_wakeup
	.long _interrupt_handler_62
	.long _interrupt_handler_63
	.long _interrupt_handler_64
	.long _interrupt_handler_65
	.long _interrupt_handler_66
	.long _interrupt_handler_67
	.long _interrupt_handler_68
	.long _interrupt_handler_timer4
	.long _interrupt_handler_spi2 # 70
	.long _interrupt_handler_uart3
	.long _interrupt_handler_uart4
	.long _interrupt_handler_timer5
	.long _interrupt_handler_timer6
	.long _interrupt_handler_dma1_0
	.long _interrupt_handler_dma1_1
	.long _interrupt_handler_dma1_2
	.long _interrupt_handler_dma1_3
	.long _interrupt_handler_dma1_4
	.long _interrupt_handler_80 # 80
	.long _interrupt_handler_81
	.long _interrupt_handler_can1_tx
	.long _interrupt_handler_can1_rx0
	.long _interrupt_handler_can1_rx1
	.long _interrupt_handler_can1_ewmc
	.long _interrupt_handler_usbfs # 86
interrupt_vector_table_end:

# "do nothing"
.weak main
.weak _interrupt_handler_clic_sft
.weak _interrupt_handler_4
.weak _interrupt_handler_5
.weak _interrupt_handler_6
.weak _interrupt_handler_clic_tmr
.weak _interrupt_handler_8
.weak _interrupt_handler_9
.weak _interrupt_handler_10
.weak _interrupt_handler_11
.weak _interrupt_handler_12
.weak _interrupt_handler_13
.weak _interrupt_handler_14
.weak _interrupt_handler_15
.weak _interrupt_handler_16
.weak _interrupt_handler_clic_bwei
.weak _interrupt_handler_clic_pmovi
.weak _interrupt_handler_wwdgt
.weak _interrupt_handler_lvd
.weak _interrupt_handler_tamper
.weak _interrupt_handler_rtc
.weak _interrupt_handler_fmc
.weak _interrupt_handler_rcu
.weak _interrupt_handler_exti_0
.weak _interrupt_handler_exti_1
.weak _interrupt_handler_exti_2
.weak _interrupt_handler_exti_3
.weak _interrupt_handler_exti_4
.weak _interrupt_handler_dma0_0
.weak _interrupt_handler_dma0_1
.weak _interrupt_handler_dma0_2
.weak _interrupt_handler_dma0_3
.weak _interrupt_handler_dma0_4
.weak _interrupt_handler_dma0_5
.weak _interrupt_handler_dma0_6
.weak _interrupt_handler_adc
.weak _interrupt_handler_can0_tx
.weak _interrupt_handler_can0_rx0
.weak _interrupt_handler_can0_rx1
.weak _interrupt_handler_can0_ewmc
.weak _interrupt_handler_exti_5_9
.weak _interrupt_handler_timer0_break
.weak _interrupt_handler_timer0_update
.weak _interrupt_handler_timer0_trigger
.weak _interrupt_handler_timer0_compare
.weak _interrupt_handler_timer1
.weak _interrupt_handler_timer2
.weak _interrupt_handler_timer3
.weak _interrupt_handler_i2c0_event
.weak _interrupt_handler_i2c0_error
.weak _interrupt_handler_i2c1_event
.weak _interrupt_handler_i2c1_error
.weak _interrupt_handler_spi0
.weak _interrupt_handler_spi1
.weak _interrupt_handler_usart0
.weak _interrupt_handler_usart1
.weak _interrupt_handler_usart2
.weak _interrupt_handler_exti_10_15
.weak _interrupt_handler_rtc_alarm
.weak _interrupt_handler_usbfs_wakeup
.weak _interrupt_handler_62
.weak _interrupt_handler_63
.weak _interrupt_handler_64
.weak _interrupt_handler_65
.weak _interrupt_handler_66
.weak _interrupt_handler_67
.weak _interrupt_handler_68
.weak _interrupt_handler_timer4
.weak _interrupt_handler_spi2
.weak _interrupt_handler_uart3
.weak _interrupt_handler_uart4
.weak _interrupt_handler_timer5
.weak _interrupt_handler_timer6
.weak _interrupt_handler_dma1_0
.weak _interrupt_handler_dma1_1
.weak _interrupt_handler_dma1_2
.weak _interrupt_handler_dma1_3
.weak _interrupt_handler_dma1_4
.weak _interrupt_handler_80
.weak _interrupt_handler_81
.weak _interrupt_handler_can1_tx
.weak _interrupt_handler_can1_rx0
.weak _interrupt_handler_can1_rx1
.weak _interrupt_handler_can1_ewmc
.weak _interrupt_handler_usbfs
main:
_interrupt_handler_clic_sft:
_interrupt_handler_4:
_interrupt_handler_5:
_interrupt_handler_6:
_interrupt_handler_clic_tmr:
_interrupt_handler_8:
_interrupt_handler_9:
_interrupt_handler_10:
_interrupt_handler_11:
_interrupt_handler_12:
_interrupt_handler_13:
_interrupt_handler_14:
_interrupt_handler_15:
_interrupt_handler_16:
_interrupt_handler_clic_bwei:
_interrupt_handler_clic_pmovi:
_interrupt_handler_wwdgt:
_interrupt_handler_lvd:
_interrupt_handler_tamper:
_interrupt_handler_rtc:
_interrupt_handler_fmc:
_interrupt_handler_rcu:
_interrupt_handler_exti_0:
_interrupt_handler_exti_1:
_interrupt_handler_exti_2:
_interrupt_handler_exti_3:
_interrupt_handler_exti_4:
_interrupt_handler_dma0_0:
_interrupt_handler_dma0_1:
_interrupt_handler_dma0_2:
_interrupt_handler_dma0_3:
_interrupt_handler_dma0_4:
_interrupt_handler_dma0_5:
_interrupt_handler_dma0_6:
_interrupt_handler_adc:
_interrupt_handler_can0_tx:
_interrupt_handler_can0_rx0:
_interrupt_handler_can0_rx1:
_interrupt_handler_can0_ewmc:
_interrupt_handler_exti_5_9:
_interrupt_handler_timer0_break:
_interrupt_handler_timer0_update:
_interrupt_handler_timer0_trigger:
_interrupt_handler_timer0_compare:
_interrupt_handler_timer1:
_interrupt_handler_timer2:
_interrupt_handler_timer3:
_interrupt_handler_i2c0_event:
_interrupt_handler_i2c0_error:
_interrupt_handler_i2c1_event:
_interrupt_handler_i2c1_error:
_interrupt_handler_spi0:
_interrupt_handler_spi1:
_interrupt_handler_usart0:
_interrupt_handler_usart1:
_interrupt_handler_usart2:
_interrupt_handler_exti_10_15:
_interrupt_handler_rtc_alarm:
_interrupt_handler_usbfs_wakeup:
_interrupt_handler_62:
_interrupt_handler_63:
_interrupt_handler_64:
_interrupt_handler_65:
_interrupt_handler_66:
_interrupt_handler_67:
_interrupt_handler_68:
_interrupt_handler_timer4:
_interrupt_handler_spi2:
_interrupt_handler_uart3:
_interrupt_handler_uart4:
_interrupt_handler_timer5:
_interrupt_handler_timer6:
_interrupt_handler_dma1_0:
_interrupt_handler_dma1_1:
_interrupt_handler_dma1_2:
_interrupt_handler_dma1_3:
_interrupt_handler_dma1_4:
_interrupt_handler_80:
_interrupt_handler_81:
_interrupt_handler_can1_tx:
_interrupt_handler_can1_rx0:
_interrupt_handler_can1_rx1:
_interrupt_handler_can1_ewmc:
_interrupt_handler_usbfs:
null_interrupt_handler:
	ret

.p2align 2
interrupt_handler_common:
	# save caller-save registers
	addi sp, sp, -80
	sw ra, 0(sp)
	sw t0, 4(sp)
	sw t1, 8(sp)
	sw t2, 12(sp)
	sw a0, 16(sp)
	sw a1, 20(sp)
	sw a2, 24(sp)
	sw a3, 28(sp)
	sw a4, 32(sp)
	sw a5, 36(sp)
	sw a6, 40(sp)
	sw a7, 44(sp)
	sw t3, 48(sp)
	sw t4, 52(sp)
	sw t5, 56(sp)
	sw t6, 60(sp)
	# save mepc, mcause, msubm
	csrrci a0, 0x341, 0
	sw a0, 64(sp)
	csrrci a0, 0x342, 0
	sw a0, 68(sp)
	csrrci a0, 0x7c4, 0
	sw a0, 72(sp)
	# call interrupt handler (CSR_JALMNXTI)
	csrrw ra, 0x7ed, ra
	# disable interrupts
	csrrci zero, 0x300, 0x8
	# restore mepc, mcause, msubm
	lw a0, 64(sp)
	csrrw zero, 0x341, a0
	lw a0, 68(sp)
	csrrw zero, 0x342, a0
	lw a0, 72(sp)
	csrrw zero, 0x7c4, a0
	# restor caller-save registers
	lw ra, 0(sp)
	lw t0, 4(sp)
	lw t1, 8(sp)
	lw t2, 12(sp)
	lw a0, 16(sp)
	lw a1, 20(sp)
	lw a2, 24(sp)
	lw a3, 28(sp)
	lw a4, 32(sp)
	lw a5, 36(sp)
	lw a6, 40(sp)
	lw a7, 44(sp)
	lw t3, 48(sp)
	lw t4, 52(sp)
	lw t5, 56(sp)
	lw t6, 60(sp)
	addi sp, sp, 80
	mret

start_code:
	# initialize stack pointer to the end of SRAM
	lui a5, %hi(0x1ffff7e0)
	lw a4, %lo(0x1ffff7e0)(a5)
	srli a4, a4, 16
	slli a4, a4, 10
	lui a3, 0x20000
	add sp, a4, a3

	# copy initialization data for .data
	lui a5, %hi(_init_data_dest_start)
	addi a5, a5, %lo(_init_data_dest_start)
	lui a4, %hi(_init_data_dest_start)
	addi a4, a4, %lo(_init_data_dest_start)
	lui a3, %hi(_init_data_src_start)
	addi a3, a3, %lo(_init_data_src_start)
	j copy_initialization_data_initial
copy_initialization_data:
	lw a2, (a3)
	sw a2, (a4)
	addi a3, a3, 4
	addi a4, a4, 4
copy_initialization_data_initial:
	bltu a4, a5, copy_initialization_data

	# initialize .bss to zero
	lui a5, %hi(_bss_end)
	addi a5, a5, %lo(_bss_end)
	lui a4, %hi(_bss_start)
	addi a4, a4, %lo(_bss_start)
	j initialize_bss_initial
initialize_bss:
	sw zero, (a4)
	addi a4, a4, 4
initialize_bss_initial:
	bltu a4, a5, initialize_bss

	# initialize interrupt handler
	csrrwi zero, 0x305, 3 # set mtvec = 3 (ECLIC Interrupt Mode)
	csrrwi zero, 0x307, 0 # set mtvt (interrupt vector) = 0
	lui a5, %hi(interrupt_handler_common)
	addi a5, a5, %lo(interrupt_handler_common)
	ori a5, a5, 1
	csrrw zero, 0x7ec, a5 # enable mtvt2 and set common interrupt handler
	lui a5, 0xd2000 # ECLIC registers base
	li a4, 1
	sb a4, (a5) # cliccfg.nlbits = 0
	sb zero, 0xb(a5) # mth = 0
	li a5, 0xd200100c
	lui a4, %hi(interrupt_vector_table)
	addi a4, a4, %lo(interrupt_vector_table)
	lui a3, %hi(interrupt_vector_table_end)
	addi a3, a3, %lo(interrupt_vector_table_end)
	lui a2, %hi(null_interrupt_handler)
	addi a2, a2, %lo(null_interrupt_handler)
initialize_interrupt_handler:
	li a0, 0xc0
	sb a0, 2(a5) # non-vectored, level triggered
	sb zero, 3(a5) # lowest level and priority
	li a0, 0
	lw a1, (a4)
	beq a1, a2, initialize_interrupt_handler_skip_enable
	li a0, 1
initialize_interrupt_handler_skip_enable:
	sb a0, 1(a5) # enable interrupt iff interrupt handler is set to non-default
	addi a5, a5, 4
	addi a4, a4, 4
	bltu a4, a3, initialize_interrupt_handler

	# execute main code
	call main

	# stop
end_loop:
	j end_loop
