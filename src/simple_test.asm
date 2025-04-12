; Simple ZX Spectrum Test Program
; For use with ZEsarUX's built-in assembler

        org 32768           ; Standard machine code start address

start:
        ld a, 2             ; Blue border
        out (254), a        ; Set border color

        call 3435           ; ROM clear screen routine

        ld a, 2             ; Open channel 2 (upper screen)
        call 5633           ; ROM open channel routine

        ld de, message      ; Point to message
        ld bc, end_message - message ; Length of message
        call 8252           ; ROM print string routine

loop:   
        jr loop             ; Loop forever

message:
        defb 22, 10, 8      ; AT 10,8
        defb "ZX SPECTRUM TEST"
end_message:

        end start 