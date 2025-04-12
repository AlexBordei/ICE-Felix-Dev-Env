; graphics.asm - ZX Spectrum assembly program

        org 32768           ; Start at 32768 (usual place for machine code)

start:
        call 3435           ; ROM clear screen routine
        
        ld a, 1             ; Red border
        out (254), a        ; Set border color
        
        ld a, 2             ; Open channel 2 (upper screen)
        call 5633           ; ROM open channel routine
        
        ld de, message      ; Point to message
        ld bc, end_message - message ; Length of message
        call 8252           ; ROM print string routine
        
loop:   
        jr loop             ; Loop forever
        
message:
        defb 22, 10, 10     ; AT 10,10
        defb "graphics"
end_message:

        end start
