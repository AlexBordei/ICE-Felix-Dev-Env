; Simple ZX Spectrum Hello World program
; Assemble with: pasmo hello.asm hello.bin

    org 32768           ; Start at 32768 (usual place for machine code)

start:
    ld a,2              ; Open channel 2 (upper screen)
    call 5633           ; Call ROM routine to open channel

    ld de,string        ; Address of string
    ld bc,eostr-string  ; Length of string to print
    call 8252           ; Print the string

    ret                 ; Return to BASIC

string:
    defb "HELLO WORLD"
eostr: 