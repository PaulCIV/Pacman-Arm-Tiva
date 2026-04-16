.data

	.global ansi_bold
	.global ansi_yellow
	.global ansi_red
	.global ansi_orange
	.global ansi_cyan
	.global ansi_pink
	.global cursor_pos
	.global pacman_string
	.global lookup_table
	.global pacman_pos
	.global pacman_dir
	.global blinky_string
	.global clyde_string
	.global inky_string
	.global pinky_string



; ANSI escape sequences for bold and colors
ansi_bold:		.string 0x1B, "[1m", 0
ansi_yellow:	.string 0x1B, "[38;5;11m", 0
ansi_red:		.string 0x1B, "[38;5;9m", 0
ansi_orange:	.string 0x1B, "[38;5;202m", 0
ansi_cyan:		.string 0x1B, "[38;5;25m", 0
ansi_pink:		.string 0x1B, "[38;5;207m", 0
ansi_blue:		.string 0x1B, "[38;5;12m", 0

; ANSI escape sequence for cursor position
cursor_pos:		.string 0x1B, "[123;456H", 0


pacman_string:	.string 0x10, 0x11, '<', 0
blinky_string:	.string 0x10, 0x12, 'A', 0	; red ghost
clyde_string:	.string 0x10, 0x13, 'A', 0	; orange ghost
inky_string:	.string 0x10, 0x14, 'A', 0	; cyan ghost
pinky_string:	.string 0x10, 0x15, 'A', 0	; pink ghost
scared_string:	.string 0x10, 0x16, 'W', 0	; scared ghosts


; Lookup table that references ANSI escape sequences
lookup_table:
		.word ansi_bold
		.word ansi_yellow
		.word ansi_red
		.word ansi_orange
		.word ansi_cyan
		.word ansi_pink
		.word ansi_blue


pacman_pos:		.byte 16, 14
pacman_dir:		.byte 0, 1

; Positions and directions for ghosts
blinky_pos:			.byte 11, 13
blinky_dir:			.byte 0, 1

clyde_pos:			.byte 11, 16
clyde_dir:			.byte 0, -1

inky_pos:			.byte 12, 13
inky_dir:			.byte 0, 1

pinky_pos:			.byte 12, 16
pinky_dir:			.byte 0, -1

; Coordinates for where each ghost will go when eaten by pacman
blinky_spawn:		.byte 11, 13
clyde_spawn:		.byte 11, 16
inky_spawn:			.byte 12, 13
pinky_spawn:		.byte 12, 16

lives:				.byte 4
is_game_over:		.byte 0
power_pellet_time:	.byte 0		; Time left until power pellet wears off in number of game ticks(not seconds)

pacman_start:		.byte 16, 14			;Pac-Man's reset/start row and column
blinky_start:		.byte 11, 13			;Blinky's reset/start row and column
clyde_start:		.byte 11, 16			;Clyde's reset/start row and column
inky_start:			.byte 12, 13			;Inky's reset/start row and column
pinky_start:		.byte 12, 16			;Pinky's reset/start row and column

board_template:								
	.ascii "############################"		; row 1 all wall 
	.ascii "#............##............#"		; row 2 
	.ascii "#.####.#####.##.#####.####.#"		; row 3 
	.ascii "#..........................#"		; row 4 
	.ascii "#.####.##.########.##.####.#"		; row 5 
	.ascii "#......##....##....##......#"		; row 6 
	.ascii "######.##### ## #####.######"		; row 7 with the ghost-box 
	.ascii "   #.##     ##.#   "		; row 8 with side openings
	.ascii "######.## ### ### ##.######"		; row 9 
	.ascii "..........#  #.......... "		; row 10 tunnel/open travel row
	.ascii "######.## ######## ##.######"		; row 11 
	.ascii "   #.##     ##.#   "		; row 12
	.ascii "######.## ######## ##.######"		; row 13
	.ascii "#............##............#"		; row 14
	.ascii "#.####.#####.##.#####.####.#"		; row 15
	.ascii "#...##................##...#"		; row 16
	.ascii "###.##.##.########.##.##.###"		; row 17
	.ascii "#......##....##....##......#"		; row 18
	.ascii "#.##########.##.##########.#"		; row 19
	.ascii "############################"		; row 20 all wall

board_current:		.space 560				;board copy, 20 rows * 28 cols = 560 bytes


	.text
	.global lab7
	.global uart_init
	.global gpio_btn_and_LED_init
	.global output_string
	.global gpio_interrupt_init
	.global uart_interrupt_init
	.global timer_interrupt_init
	.global int2str
	.global output_character
	.global simple_read_character

	.global Timer_Handler
	.global UART0_Handler
	.global Switch_Handler

	.global lookup_table
	.global ptr_to_pacman_string


ptr_to_cursor_pos:			.word cursor_pos
ptr_to_pacman_string:		.word pacman_string
ptr_to_pacman_pos:			.word pacman_pos
ptr_to_pacman_dir:			.word pacman_dir

ptr_to_blinky_string:		.word blinky_string
ptr_to_blinky_pos:			.word blinky_pos
ptr_to_blinky_dir:			.word blinky_dir
ptr_to_clyde_string:		.word clyde_string
ptr_to_clyde_pos:			.word clyde_pos
ptr_to_clyde_dir:			.word clyde_dir
ptr_to_inky_string:			.word inky_string
ptr_to_inky_pos:			.word inky_pos
ptr_to_inky_dir:			.word inky_dir
ptr_to_pinky_string:		.word pinky_string
ptr_to_pinky_pos:			.word pinky_pos
ptr_to_pinky_dir:			.word pinky_dir
ptr_to_scared_string:		.word scared_string

ptr_to_blinky_spawn:		.word blinky_spawn
ptr_to_clyde_spawn:			.word clyde_spawn
ptr_to_inky_spawn:			.word inky_spawn
ptr_to_pinky_spawn:			.word pinky_spawn

ptr_to_lives:				.word lives
ptr_to_is_game_over:		.word is_game_over
ptr_to_power_pellet_time:	.word power_pellet_time

ptr_to_board_template:		.word board_template		; immutable template board
ptr_to_board_current:		.word board_current			; mutable live board
ptr_to_pacman_start:		.word pacman_start			; Pac-Man start position
ptr_to_blinky_start:		.word blinky_start			; Blinky start position
ptr_to_clyde_start:			.word clyde_start			; Clyde start position
ptr_to_inky_start:			.word inky_start			; Inky start position
ptr_to_pinky_start:			.word pinky_start			; Pinky start position


; Offset used for indexing in lookup table
BOLD:		.equ 0x10
YELLOW:		.equ 0x11
RED:		.equ 0x12
ORANGE:		.equ 0x13
cyan:		.equ 0x14
PINK:		.equ 0x15

BOARD_ROWS:	.equ 20							; number of board rows
BOARD_COLS:	.equ 28							; number of board columns


lab7:
		PUSH {r4-r12, lr}

		; Initialization
		bl uart_init
		bl gpio_btn_and_LED_init
		bl gpio_interrupt_init
		bl uart_interrupt_init
		bl timer_interrupt_init

		bl init_board						; copy the template maze into the live mutable board
		bl draw_board						; draw the whole board before drawing characters on top
		bl draw_entities					; draw Pac-Man and all ghosts at their current positions

lab7_main_loop:

		b lab7_main_loop


		POP {r4-r12, lr}
		MOV pc, lr


Timer_Handler:
		PUSH {r4-r12, lr}

		mov r0, #0x0024		; Clear the interrupt pin
		movt r0, #0x4003
		ldr r1, [r0]
		orr r1, r1, #1
		str r1, [r0]

		bl move_ghosts		; Update ghosts' position and redraw
		bl check_ghost_coll
		bl move_pacman		; Update pacman position and redraw
		bl check_ghost_coll	; Checking twice to prevent jumping over


		;;;;;;;;;; Output lives count. For debugging
		mov r0, #35
		mov r1, #1
		bl move_cursor
		ldr r0, ptr_to_lives
		ldrb r1, [r0]
		add r0, r1, #48
		bl output_character
		;;;;;;;;;;

		POP {r4-r12, lr}
		BX lr


UART0_Handler:
    PUSH  {r4-r12, lr}

    ; clear UART receive interrupt by writing bit 4 to UARTICR
    MOV   r0, #0xC044
    MOVT  r0, #0x4000
    MOV   r1, #1
    LSL   r1, r1, #4
    STR   r1, [r0]

		bl simple_read_character	; Stores pressed char in r0
		cmp r0, #0x77		; 'w'
		beq update_dir_up
		cmp r0, #0x61		; 'a'
		beq update_dir_left
		cmp r0, #0x73		; 's'
		beq update_dir_down
		cmp r0, #0x64		; 'd'
		beq update_dir_right
		b not_wasd

update_dir_up:
		ldr r0, ptr_to_pacman_dir
		mov r1, #-1
		mov r2, #0
		b store_new_dir
update_dir_left:
		ldr r0, ptr_to_pacman_dir
		mov r1, #0
		mov r2, #-1
		b store_new_dir
update_dir_down:
		ldr r0, ptr_to_pacman_dir
		mov r1, #1
		mov r2, #0
		b store_new_dir
update_dir_right:
		ldr r0, ptr_to_pacman_dir
		mov r1, #0
		mov r2, #1
		b store_new_dir
store_new_dir:
		strb r1, [r0]
		strb r2, [r0, #1]

not_wasd:

    POP   {r4-r12, lr}
    BX   lr


Switch_Handler:
    PUSH  {r4-r12, lr}
    POP   {r4-r12, lr}
    BX   lr


; Moves cursor to position (line, column) where line=r0, column=r1.
move_cursor:
		PUSH {r4-r12, lr}

		mov r4, r0		; Preserve line and column
		mov r5, r1		; r4=line, r5=column

		ldr r0, ptr_to_cursor_pos
		add r0, r0, #2		; Add 2 to skip ESC and '['
		mov r1, r4
		bl int2str			; Store line as string

		ldr r0, ptr_to_cursor_pos
		bl find_null		; r0 = address just after line
		mov r1, #0x3B		; 0x3B is the ASCII value for ';'
		strb r1, [r0], #1	; Store ';' after line and increment r0

		mov r1, r5			; r1 = column
		bl int2str			; Store column as string

		ldr r0, ptr_to_cursor_pos
		bl find_null		; r0 = address just after column
		mov r1, #0x48		; 0x48 is the ASCII value for 'H'
		strb r1, [r0], #1	; Store 'H' after column and increment r0
		mov r1, #0
		strb r1, [r0]		; Store null char at the end

		ldr r0, ptr_to_cursor_pos
		bl output_string	; Move cursor to position stored in memory

		POP {r4-r12, lr}
		MOV pc, lr


; Given the address of a string in r0, returns the address of the first null character.
; Used for move_cursor because int2str adds a null char at the end.
find_null:
		PUSH {lr}

find_null_loop:
		ldrb r1, [r0], #1		; Load character and increment r0
		cmp r1, #0				; If character != 0, keep looping
		bne find_null_loop
		sub r0, r0, #1

		POP {lr}
		MOV pc, lr


move_pacman:
		PUSH {r4-r12, lr}

		ldr r2, ptr_to_pacman_pos				; load pointer to Pac-Man's current position bytes
		ldrb r6, [r2]							; r6 = current Pac-Man row
		ldrb r7, [r2, #1]						; r7 = current Pac-Man column

		ldr r3, ptr_to_pacman_dir				; load pointer to Pac-Man's current direction bytes
		ldrsb r4, [r3]							; r4 = signed row direction 
		ldrsb r5, [r3, #1]						; r5 = signed column direction 

		add r0, r6, r4							; comp next row into r0
		add r1, r7, r5							; comp next column into r1

		bl check_pacman_wrap					; apply tunnel wrap-around if person hits left/right tunnel

		mov r8, r0								; save wrapped row in r8
		mov r9, r1								; save wrapped column in r9

		mov r0, r8								; place row in r0 for wall-check
		mov r1, r9								; place column in r1 for wall-check
		bl check_wall							; check whether persons destination is a wall
		cmp r0, #1								; compare returned result against 1, 1 meaning "is wall"
		beq pacman_keep_old_pos					; if destination is a wall, keep old position

		mov r10, r8								; if no wall, final row becomes row
		mov r11, r9								; if no wall, final column becomes column
		b pacman_have_final_pos					; skip the "keep old position" case

pacman_keep_old_pos:
		mov r10, r6								; final row stays as old row because movement hit a wall
		mov r11, r7								; final column stays as old column because movement hit a wall

pacman_have_final_pos:
		mov r0, r6								; old row passed to draw_tile_at so old tile gets restored
		mov r1, r7								; old column passed to draw_tile_at so old tile gets restored
		bl draw_tile_at							; redraw underlying board tile where Pac-Man used to be

		ldr r2, ptr_to_pacman_pos				; reload pointer to live Pac-Man position
		strb r10, [r2]							; store final row back into pacman_pos
		strb r11, [r2, #1]						; store final column back into pacman_pos

		mov r0, r10								; put final row into r0 for pellet-eating check
		mov r1, r11								; put final column into r1 for pellet-eating check
		bl eat_pellet_if_present				; if Pac-Man landed on '.', remove it from board_current

		mov r0, r10								; put final row into r0 for cursor move to Pac-Man's new position
		mov r1, r11								; put final column into r1 for cursor move to Pac-Man's new position
		bl move_cursor							; move terminal cursor to Pac-Man's new position
		ldr r0, ptr_to_pacman_string			; load address of Pac-Man display string
		bl output_string						; draw Pac-Man at new/final position

		POP {r4-r12, lr}
		MOV pc, lr


; Checks if pacman collided with a ghost.
; r0 = pacman line pos, r1 = pacman column pos
check_ghost_coll:
		PUSH {r4-r12, lr}

		ldr r6, ptr_to_pacman_pos
		ldrb r4, [r6]		; r4 = pacman line pos
		ldrb r5, [r6, #1]	; r5 = pacman column pos

		ldr r0, ptr_to_blinky_pos
		ldrb r1, [r0]		; r1 = blinky line pos
		ldrb r2, [r0, #1]	; r2 = blinky col pos
		cmp r4, r1			; Check if positions match
		bne blinky_nocoll
		cmp r5, r2
		bne blinky_nocoll
		ldr r6, ptr_to_power_pellet_time	; Check if power pellet is active
		ldrb r6, [r6]
		cmp r6, #0			; If power pellet is not active, pacman dead. Otherwise ghost eaten
		beq normal_ghost_coll	; Pacman position = blinky position
		ldr r0, ptr_to_blinky_pos		; Pass pos, spawn, dir to ghost_eaten
		ldr r1, ptr_to_blinky_spawn
		ldr r2, ptr_to_blinky_dir
		bl ghost_eaten
		b exit_check_ghost_coll
blinky_nocoll:				; No collision with blinky
		ldr r0, ptr_to_clyde_pos
		ldrb r1, [r0]		; r1 = clyde line pos
		ldrb r2, [r0, #1]	; r2 = clyde col pos
		cmp r4, r1			; Check if positions match
		bne clyde_nocoll
		cmp r5, r2
		bne clyde_nocoll
		ldr r6, ptr_to_power_pellet_time	; Check if power pellet is active
		ldrb r6, [r6]
		cmp r6, #0			; If power pellet is not active, pacman dead. Otherwise ghost eaten
		beq normal_ghost_coll	; Pacman position = clyde position
		ldr r0, ptr_to_clyde_pos		; Pass pos, spawn, dir to ghost_eaten
		ldr r1, ptr_to_clyde_spawn
		ldr r2, ptr_to_clyde_dir
		bl ghost_eaten
		b exit_check_ghost_coll
clyde_nocoll:				; No collision with clyde
		ldr r0, ptr_to_inky_pos
		ldrb r1, [r0]		; r1 = inky line pos
		ldrb r2, [r0, #1]	; r2 = inky col pos
		cmp r4, r1			; Check if positions match
		bne inky_nocoll
		cmp r5, r2
		bne inky_nocoll
		ldr r6, ptr_to_power_pellet_time	; Check if power pellet is active
		ldrb r6, [r6]
		cmp r6, #0			; If power pellet is not active, pacman dead. Otherwise ghost eaten
		beq normal_ghost_coll	; Pacman position = inky position
		ldr r0, ptr_to_inky_pos		; Pass pos, spawn, dir to ghost_eaten
		ldr r1, ptr_to_inky_spawn
		ldr r2, ptr_to_inky_dir
		bl ghost_eaten
		b exit_check_ghost_coll
inky_nocoll:				; No collision with inky
		ldr r0, ptr_to_pinky_pos
		ldrb r1, [r0]		; r1 = pinky line pos
		ldrb r2, [r0, #1]	; r2 = pinky col pos
		cmp r4, r1			; Check if positions match
		bne pinky_nocoll
		cmp r5, r2
		bne pinky_nocoll
		ldr r6, ptr_to_power_pellet_time	; Check if power pellet is active
		ldrb r6, [r6]
		cmp r6, #0			; If power pellet is not active, pacman dead. Otherwise ghost eaten
		beq normal_ghost_coll	; Pacman position = pinky position
		ldr r0, ptr_to_pinky_pos		; Pass pos, spawn, dir to ghost_eaten
		ldr r1, ptr_to_pinky_spawn
		ldr r2, ptr_to_pinky_dir
		bl ghost_eaten
		b exit_check_ghost_coll
pinky_nocoll:				; No collision with pinky
		b exit_check_ghost_coll

normal_ghost_coll:			; Power pellet isn't active
		bl pacman_dead
exit_check_ghost_coll:

		POP {r4-r12, lr}
		MOV pc, lr


; Called when scared ghost collides with pacman
; r0 = ptr to ghost pos
; r1 = ptr to ghost spawn
; r2 = ptr to ghost dir
ghost_eaten:
		PUSH {r4-r12, lr}

		ldrb r4, [r0]							; read the ghost's current row before teleporting it
		ldrb r5, [r0, #1]						; read the ghost's current column before teleporting it
		mov r10, r4								; save old ghost row so we can redraw that tile later
		mov r11, r5								; save old ghost column so we can redraw that tile later

		; Teleport ghost to its spawn
		ldrb r4, [r1]		; r4 = spawn line
		ldrb r5, [r1, #1]	; r5 = spawn column
		strb r4, [r0]
		strb r5, [r0, #1]

		; Make ghost move up (needs to move up and down within box)
		mov r4, #1
		mov r5, #0
		strb r4, [r2]
		strb r5, [r2, #1]

		mov r0, r10								; pass old ghost row to redraw helper
		mov r1, r11								; pass old ghost column to redraw helper
		bl draw_tile_at							; put back pellet or space that was underneath the ghost

		POP {r4-r12, lr}
		MOV pc, lr


pacman_dead:
		PUSH {r4-r12, lr}

		; Decrement lives
		ldr r4, ptr_to_lives
		ldrb r5, [r4]
		sub r5, r5, #1
		strb r5, [r4]

		; If lives = 0, set game over flag. Otherwise reset board
		cmp r5, #0
		bne not_game_over
		mov r6, #1
		ldr r4, ptr_to_is_game_over
		strb r6, [r4]
		b exit_pacman_dead

not_game_over:
		bl reset_board
exit_pacman_dead:

		POP {r4-r12, lr}
		MOV pc, lr


reset_board:
		PUSH {r4-r12, lr}

		bl init_board							; rebuild the board from the original temp

		ldr r0, ptr_to_pacman_start				; r0 = Pac-Man's start position
		ldr r1, ptr_to_pacman_pos				; r1 = live Pac-Man position
		ldrb r2, [r0]							; r2 = start row for Pac-Man
		ldrb r3, [r0, #1]						; r3 = start column for Pac-Man
		strb r2, [r1]							; reset Pac-Man row to start row
		strb r3, [r1, #1]						; reset Pac-Man column to start column

		ldr r0, ptr_to_blinky_start				; r0 = Blinky start position
		ldr r1, ptr_to_blinky_pos				; r1 = live Blinky position
		ldrb r2, [r0]							; r2 = Blinky start row
		ldrb r3, [r0, #1]						; r3 = Blinky start column
		strb r2, [r1]							; reset Blinky row
		strb r3, [r1, #1]						; reset Blinky column

		ldr r0, ptr_to_clyde_start				; r0 = Clyde start position
		ldr r1, ptr_to_clyde_pos				; r1 = live Clyde position
		ldrb r2, [r0]							; r2 = Clyde start row
		ldrb r3, [r0, #1]						; r3 = Clyde start column
		strb r2, [r1]							; reset Clyde row
		strb r3, [r1, #1]						; reset Clyde column

		ldr r0, ptr_to_inky_start				; r0 = Inky start position
		ldr r1, ptr_to_inky_pos					; r1 = live Inky position
		ldrb r2, [r0]							; r2 = Inky start row
		ldrb r3, [r0, #1]						; r3 = Inky start column
		strb r2, [r1]							; reset Inky row
		strb r3, [r1, #1]						; reset Inky column

		ldr r0, ptr_to_pinky_start				; r0 = Pinky start position
		ldr r1, ptr_to_pinky_pos				; r1 = live Pinky position
		ldrb r2, [r0]							; r2 = Pinky start row
		ldrb r3, [r0, #1]						; r3 = Pinky start column
		strb r2, [r1]							; reset Pinky row
		strb r3, [r1, #1]						; reset Pinky column

		ldr r0, ptr_to_pacman_dir				; load Pac-Man direction 
		mov r1, #0								; row delta = 0
		mov r2, #1								; col delta = +1 so Pac-Man starts moving right
		strb r1, [r0]							; Pac-Man row direction
		strb r2, [r0, #1]						; Pac-Man column direction

		ldr r0, ptr_to_blinky_dir				; Blinky direction address
		mov r1, #0								; row delta = 0
		mov r2, #1								; col delta = +1
		strb r1, [r0]							; reset Blinky row direction
		strb r2, [r0, #1]						; reset Blinky column direction

		ldr r0, ptr_to_clyde_dir				; Clyde direction address
		mov r1, #0								; row delta = 0
		mov r2, #-1								; col delta = -1
		strb r1, [r0]							; reset Clyde row direction
		strb r2, [r0, #1]						; reset Clyde column direction

		ldr r0, ptr_to_inky_dir					; Inky direction address
		mov r1, #0								; row delta = 0
		mov r2, #1								; col delta = +1
		strb r1, [r0]							; reset Inky row direction
		strb r2, [r0, #1]						; reset Inky column direction

		ldr r0, ptr_to_pinky_dir				; Pinky direction address
		mov r1, #0								; row delta = 0
		mov r2, #-1								; col delta = -1
		strb r1, [r0]							; reset Pinky row direction
		strb r2, [r0, #1]						; reset Pinky column direction

		bl draw_board							; redraw the board after reset
		bl draw_entities						; redraw Pac-Man and ghosts after reset

		POP {r4-r12, lr}
		MOV pc, lr


; Checks if pacman needs to wrap-around map
; r0 = pacman line pos, r1 = pacman column pos
check_pacman_wrap:
		PUSH {lr}

		cmp r0, #10								; only allow left/right wrap when Pac-Man is on the tunnel row
		bne pacman_no_tunnel_wrap				; if not on tunnel row, skip wrap 

		cmp r1, #28								; check whether Pac-Man moved past the right tunnel edge
		ble pacman_no_rightwrap					; if not past right edge, test left edge 
		mov r1, #1								; wrap from right edge to column 1
		b exit_pacman_wrap						; wrap complete, skip rest of function

pacman_no_rightwrap:
		cmp r1, #1								; check whether Pac-Man moved past the left tunnel
		bge exit_pacman_wrap					; if still on board, no wrap 
		mov r1, #28								; wrap from just before left edge to column 28
		b exit_pacman_wrap						; finish function after left-wrap

pacman_no_tunnel_wrap:

exit_pacman_wrap:

		POP {lr}
		MOV pc, lr


move_ghosts:
		PUSH {r4-r12, lr}

		ldr r0, ptr_to_blinky_pos
		ldr r1, ptr_to_blinky_dir
		ldr r2, ptr_to_blinky_string
		bl move_oneghost

		ldr r0, ptr_to_clyde_pos
		ldr r1, ptr_to_clyde_dir
		ldr r2, ptr_to_clyde_string
		bl move_oneghost

		ldr r0, ptr_to_inky_pos
		ldr r1, ptr_to_inky_dir
		ldr r2, ptr_to_inky_string
		bl move_oneghost

		ldr r0, ptr_to_pinky_pos
		ldr r1, ptr_to_pinky_dir
		ldr r2, ptr_to_pinky_string
		bl move_oneghost

		POP {r4-r12, lr}
		MOV pc, lr


; r0 = ghost pos address
; r1 = ghost dir address
; r2 = ghost string address
move_oneghost:
		PUSH {r4-r12, lr}

		mov r4, r0								;save pointer to this ghost's live position 
		mov r9, r1								;save pointer to this ghost's live direction 
		mov r10, r2								;save pointer to the normal display 
		
		ldrb r5, [r4]							;r5 = current ghost row
		ldrb r6, [r4, #1]						;r6 = current ghost column

		mov r0, r5								;pass old row into tile redraw helper
		mov r1, r6								;pass old column into tile redraw helper
		bl draw_tile_at							;restore whatever was under the ghost before moving it

		ldrsb r7, [r9]							;r7 = signed row direction delta for ghost
		ldrsb r8, [r9, #1]						;r8 = signed column direction delta for ghost

		add r0, r5, r7							;comp next row
		add r1, r6, r8							;comp next column

		cmp r0, #10								;only do tunnel wrap if ghost is on tunnel row
		bne ghost_no_tunnel_wrap				;if not on tunnel row, skip wrap logic
		cmp r1, #28								;test right-side tunnel overflow
		ble ghost_no_rightwrap					;if not beyond right edge, test left edge
		mov r1, #1								;wrap right exit to column 1
		b ghost_wrap_done						;skip remaining wrap checks
ghost_no_rightwrap:
		cmp r1, #1								;test left-side tunnel overflow
		bge ghost_wrap_done						;if still in range, no wrap needed
		mov r1, #28								;wrap left exit to column 28
		b ghost_wrap_done						;finish wrap handling
ghost_no_tunnel_wrap:
ghost_wrap_done:

		mov r11, r0								; save row after wrap into r11
		mov r12, r1								; save column after wrap into r12

		mov r0, r11								; pass row into wall checker
		mov r1, r12								; pass column into wall checker
		bl check_wall							; check whether ghost destination is a wall
		cmp r0, #1								; compare result against 1, 1 meaning "wall"
		bne ghost_store_new_pos					; if destination is not a wall, keep this move

		ldrsb r7, [r9]							; reload current row direction
		ldrsb r8, [r9, #1]						; reload current column direction
		rsb r7, r7, #0							; reverse row direction 
		rsb r8, r8, #0							; reverse column direction 
		strb r7, [r9]							; store reversed row direction 
		strb r8, [r9, #1]						; store reversed column direction 

		add r11, r5, r7							; comp new row using reversed direction
		add r12, r6, r8							; comp new column using reversed direction

		mov r0, r11								; pass reversed row into wall checker
		mov r1, r12								; pass reversed column into wall checker
		bl check_wall							; check whether reversed destination is a wall
		cmp r0, #1								; compare result against 1, 1 meaning "wall"
		bne ghost_store_new_pos					; if reversed move is valid, do it

		mov r11, r5								; if both directions hit walls, stay on current row
		mov r12, r6								; if both directions hit walls, stay on current column

ghost_store_new_pos:
		strb r11, [r4]							; store final ghost row 
		strb r12, [r4, #1]						; store final ghost column 
		
		mov r0, r11								; move cursor to final ghost row
		mov r1, r12								; move cursor to final ghost column
		bl move_cursor							; place cursor at final ghost position
		ldr r4, ptr_to_power_pellet_time		; load address of power pellet timer
		ldrb r4, [r4]							; read remaining power pellet timer
		cmp r4, #0								; check whether power pellet mode is active
		beq print_normal_ghost					; if not active, draw normal ghost string
		ldr r10, ptr_to_scared_string			; if active, replace normal ghost string with frightened one
print_normal_ghost:
		mov r0, r10								; r0 = string pointer to output for this ghost
		bl output_string						; draw ghost at its final location

		POP {r4-r12, lr}
		MOV pc, lr


check_wall:
		PUSH {r4-r12, lr}

		bl get_board_addr						; convert row/column in r0/r1 
		ldrb r1, [r0]							; load tile character 
		cmp r1, #'#'							; compare tile against wall character '#'
		moveq r0, #1							; if tile is '#', return 1 meaning "this is a wall"
		movne r0, #0							; if tile is not '#', return 0 meaning "not a wall"

		POP {r4-r12, lr}
		MOV pc, lr


init_board:
		PUSH {r4-r12, lr}						

		ldr r0, ptr_to_board_template			; r0 = source pointer 
		ldr r1, ptr_to_board_current			; r1 = destination pointer 
		mov r2, #560							; r2 = number of bytes 

init_board_loop:
		ldrb r3, [r0], #1						; load one byte from template and post-increment 
		strb r3, [r1], #1						; store that byte into live board and post-increment 
		subs r2, r2, #1							; update condition flags
		bne init_board_loop						; loop until all 560 bytes are copied

		POP {r4-r12, lr}						
		MOV pc, lr								


draw_board:
		PUSH {r4-r12, lr}						

		mov r4, #1								; r4 = current row number, starting at row 1
		ldr r5, ptr_to_board_current			; r5 = pointer walking through live board bytes

draw_board_row_loop:
		mov r6, #1								; r6 = current column number, starting at col 1 for each new row

draw_board_col_loop:
		mov r0, r4								; put current row into r0 for move_cursor
		mov r1, r6								; put current col into r1 for move_cursor
		bl move_cursor							; move terminal cursor to this board cell

		ldrb r0, [r5], #1						; load board character at current cell and advance board pointer
		bl output_character						; print that board character on screen

		add r6, r6, #1							; advance column counter to next column
		cmp r6, #29								; compare against 29 because valid visible columns are 1..28
		blt draw_board_col_loop					; if still within row, continue drawing next column

		add r4, r4, #1							; advance row counter to next row
		cmp r4, #21								; compare against 21 because valid visible rows are 1..20
		blt draw_board_row_loop					; if still within board, continue drawing next row

		POP {r4-r12, lr}						
		MOV pc, lr								


draw_entities:
		PUSH {r4-r12, lr}						
		ldr r2, ptr_to_pacman_pos				; load Pac-Man live position
		ldrb r0, [r2]							; r0 = Pac-Man row
		ldrb r1, [r2, #1]						; r1 = Pac-Man column
		bl move_cursor							; move cursor to Pac-Man location
		ldr r0, ptr_to_pacman_string			; load Pac-Man pointer
		bl output_string						; draw Pac-Man

		ldr r2, ptr_to_blinky_pos				; load pointer to Blinky live position
		ldrb r0, [r2]							; r0 = Blinky row
		ldrb r1, [r2, #1]						; r1 = Blinky column
		bl move_cursor							; move cursor to Blinky location
		ldr r0, ptr_to_blinky_string			; load Blinky pointer
		bl output_string						; draw Blinky

		ldr r2, ptr_to_clyde_pos				; load pointer to Clyde live position
		ldrb r0, [r2]							; r0 = Clyde row
		ldrb r1, [r2, #1]						; r1 = Clyde column
		bl move_cursor							; move cursor to Clyde location
		ldr r0, ptr_to_clyde_string				; load Clyde pointer
		bl output_string						; draw Clyde

		ldr r2, ptr_to_inky_pos					; load pointer to Inky live position
		ldrb r0, [r2]							; r0 = Inky row
		ldrb r1, [r2, #1]						; r1 = Inky column
		bl move_cursor							; move cursor to Inky location
		ldr r0, ptr_to_inky_string				; load Inky pointer
		bl output_string						; draw Inky

		ldr r2, ptr_to_pinky_pos				; load pointer to Pinky live position
		ldrb r0, [r2]							; r0 = Pinky row
		ldrb r1, [r2, #1]						; r1 = Pinky column
		bl move_cursor							; move cursor to Pinky location
		ldr r0, ptr_to_pinky_string				; load Pinky pointer
		bl output_string						; draw Pinky

		POP {r4-r12, lr}						
		MOV pc, lr								


get_board_addr:
		PUSH {r4-r12, lr}						

		sub r2, r0, #1							; convert 1-based row in r0 to 0-based row index in r2
		sub r3, r1, #1							; convert 1-based col in r1 to 0-based col index in r3

		mov r4, #28								; r4 = number of columns per board row
		mul r2, r2, r4							; r2 = row_index * 28, 
		add r2, r2, r3							; r2 = row byte offset + column offset

		ldr r0, ptr_to_board_current			; r0 = base address of live board
		add r0, r0, r2							; r0 = final address of requested board cell

		POP {r4-r12, lr}						
		MOV pc, lr								


draw_tile_at:
		PUSH {r4-r12, lr}						

		mov r4, r0								; save input row because get_board_addr will overwrite r0
		mov r5, r1								; save input column because get_board_addr will overwrite r1

		bl get_board_addr						; convert requested row/col into address 
		ldrb r6, [r0]							; load tile character currently stored at that board location

		mov r0, r4								; restore row into r0 for move_cursor
		mov r1, r5								; restore column into r1 for move_cursor
		bl move_cursor							; move terminal cursor to the requested tile location

		mov r0, r6								; move tile character into r0 for output_character
		bl output_character						; print tile character
		POP {r4-r12, lr}						
		MOV pc, lr								


eat_pellet_if_present:
		PUSH {r4-r12, lr}						

		bl get_board_addr						; convert Pac-Man's current row/col into address 
		ldrb r1, [r0]							; load tile character at Pac-Man's current location
		cmp r1, #'.'							; compare tile against normal pellet character '.'
		bne eat_pellet_done						; if not a pellet, nothing to remove
		mov r1, #' '							; replace pellet with blank/open space character
		strb r1, [r0]							; store blank into live board 

eat_pellet_done:
		POP {r4-r12, lr}						
		MOV pc, lr								

	.end