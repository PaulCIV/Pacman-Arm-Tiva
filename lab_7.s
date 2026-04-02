.data

; ANSI escape sequences for colors
ansi_red:		.string 0x1B, "[38;5;9m", 0
ansi_green:		.string 0x1B, "[38;5;10m", 0
ansi_blue:		.string 0x1B, "[38;5;12m", 0
ansi_yellow:	.string 0x1B, "[38;5;11m", 0

pacman_string:	.string 0x13, '<', 0


; Lookup table that references ANSI escape sequences
lookup_table:
		.word ansi_red
		.word ansi_green
		.word ansi_blue
		.word ansi_yellow


ptr_to_pacman_string:		.word pacman_string


.text
		.global lab7
		.global uart_init
		.global gpio_btn_and_LED_init
		.global output_string

		.global Timer_Handler
		.global UART0_Handler
		.global Switch_Handler

		.global lookup_table
		.global ptr_to_pacman_string

; Offset used for indexing in lookup table
RED:		.equ 0x10
GREEN:		.equ 0x11
BLUE:		.equ 0x12
YELLOW:		.equ 0x13


lab7:
		PUSH {r4-r12, lr}

		bl uart_init
		bl gpio_btn_and_LED_init

		ldr r0, ptr_to_pacman_string
		bl output_string


		POP {r4-r12, lr}
		MOV pc, lr


Timer_Handler:
		PUSH {r4-r12, lr}
		POP {r4-r12, lr}
		BX lr

UART0_Handler:
        PUSH    {r4-r12, lr}
        POP     {r4-r12, lr}
        BX      lr

Switch_Handler:
        PUSH    {r4-r12, lr}
        POP     {r4-r12, lr}
        BX      lr

	.end
