#!/bin/bash

# ZX Spectrum Development Environment
# Usage: ./zx.sh [command] [file]
#
# Commands:
#   run       - Start ZEsarUX emulator
#   basic     - Create a new BASIC program
#   asm       - Create a new assembly program
#   help      - Show this help message

# ZEsarUX path
ZESARUX="/Applications/ZEsarUX.app/Contents/MacOS/zesarux"

# Check if ZEsarUX exists
if [ ! -f "$ZESARUX" ]; then
    echo "Error: ZEsarUX not found at $ZESARUX"
    echo "Please make sure ZEsarUX is installed in Applications folder"
    exit 1
fi

# Create directories if they don't exist
mkdir -p src roms

# Show usage
show_usage() {
    echo "ZX Spectrum Development Environment"
    echo "Usage: ./zx.sh [command] [file]"
    echo ""
    echo "Commands:"
    echo "  run                  - Start ZEsarUX emulator"
    echo "  basic [filename]     - Create a new BASIC program"
    echo "  asm [filename]       - Create a new assembly program"
    echo "  help                 - Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./zx.sh run          - Start the emulator"
    echo "  ./zx.sh basic game   - Create src/game.bas"
    echo "  ./zx.sh asm sprite   - Create src/sprite.asm"
}

# Create a new BASIC program
create_basic() {
    if [ -z "$1" ]; then
        echo "Error: No filename specified"
        show_usage
        exit 1
    fi
    
    filename="src/$1.bas"
    
    if [ -f "$filename" ]; then
        echo "File $filename already exists"
        exit 1
    fi
    
    echo "Creating new BASIC program: $filename"
    cat > "$filename" << EOF
10 REM $1.bas - ZX Spectrum BASIC program
20 BORDER 1: PAPER 0: INK 7: CLS
30 PRINT AT 10,8;"$1"
40 PRINT AT 12,6;"PRESS ANY KEY"
50 PAUSE 0
60 REM Your code here
EOF
    
    echo "Created $filename"
    echo "To run it, start ZEsarUX with ./zx.sh run"
    echo "Then use File > Smart Load > $filename"
}

# Create a new assembly program
create_asm() {
    if [ -z "$1" ]; then
        echo "Error: No filename specified"
        show_usage
        exit 1
    fi
    
    filename="src/$1.asm"
    
    if [ -f "$filename" ]; then
        echo "File $filename already exists"
        exit 1
    fi
    
    echo "Creating new assembly program: $filename"
    cat > "$filename" << EOF
; $1.asm - ZX Spectrum assembly program

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
        defb "$1"
end_message:

        end start
EOF
    
    echo "Created $filename"
    echo "To assemble and run:"
    echo "1. Start ZEsarUX with ./zx.sh run"
    echo "2. In ZEsarUX, access the built-in assembler via Tools menu"
    echo "3. Load and assemble this file"
}

# Main command processing
case "$1" in
    run)
        echo "Starting ZEsarUX..."
        "$ZESARUX" --machine 48k --tbblue-fast-boot-mode
        ;;
    basic)
        create_basic "$2"
        ;;
    asm)
        create_asm "$2"
        ;;
    help|*)
        show_usage
        ;;
esac 