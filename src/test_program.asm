; ZX Spectrum Test Program
; Demonstrates various programming concepts

    org 32768           ; Standard machine code start address

; Constants
ATTR_ADDR equ 22528    ; Attribute memory start
SCREEN_ADDR equ 16384  ; Screen memory start
BORDER equ 0x229B      ; BORDER system variable

; Program entry point
start:
    call init_program   ; Initialize program
    call main_loop      ; Enter main loop
    ret                 ; Should never reach here

; Initialize program
init_program:
    call clear_screen   ; Clear the screen
    call set_border     ; Set border color
    call print_title    ; Print title
    call init_player    ; Initialize player position
    ret

; Clear screen and attributes
clear_screen:
    call 3435          ; ROM clear screen routine
    ld hl,ATTR_ADDR    ; Start of attributes
    ld de,ATTR_ADDR+1  ; Next attribute
    ld bc,767          ; Number of attributes - 1
    ld (hl),56         ; White ink (7) on black paper (0)
    ldir               ; Fill attributes
    ret

; Set border color
set_border:
    ld a,2             ; Blue border
    out (254),a        ; Set border color
    ret

; Print title
print_title:
    ld a,2             ; Open channel 2 (upper screen)
    call 5633          ; ROM open channel routine

    ld de,title        ; Address of string
    ld bc,title_end-title ; Length of string
    call 8252          ; ROM print string routine
    ret

; Initialize player position
init_player:
    ld hl,SCREEN_ADDR+11*32+16 ; Center of screen
    ld (player_pos),hl ; Store player position
    ret

; Main game loop
main_loop:
    call read_keys     ; Read keyboard input
    call update_player ; Update player position
    call draw_screen   ; Draw everything
    jr main_loop       ; Loop forever

; Read keyboard input
read_keys:
    ld bc,0xFEFE       ; First keyboard row
    in a,(c)           ; Read keyboard
    bit 0,a            ; Check CAPS SHIFT
    jr nz,not_up       ; Not pressed
    ld a,(player_pos)  ; Get Y position
    cp 0               ; At top?
    jr z,not_up        ; Yes, don't move
    sub 32             ; Move up one line
    ld (player_pos),a  ; Store new position
not_up:
    bit 1,a            ; Check Z
    jr nz,not_down     ; Not pressed
    ld a,(player_pos)  ; Get Y position
    cp 21*32           ; At bottom?
    jr z,not_down      ; Yes, don't move
    add a,32           ; Move down one line
    ld (player_pos),a  ; Store new position
not_down:
    ret

; Update player position
update_player:
    ld hl,(player_pos) ; Get player position
    ld (hl),0          ; Clear current position
    ret

; Draw everything on screen
draw_screen:
    ld hl,(player_pos) ; Get player position
    ld (hl),255        ; Draw player (solid block)
    ret

; Data section
title:
    defb 22,10,10      ; AT 10,10
    defb "ZX TEST PROGRAM"
    defb 13            ; New line
    defb "USE CAPS+Z TO MOVE"
title_end:

; Variables
player_pos:
    defw 0             ; Player position (2 bytes) 