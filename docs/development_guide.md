# ZX Spectrum Development Guide

## 1. Setting Up Your Development Environment

### Required Tools
- ZEsarUX emulator (installed in Applications folder)
- Z80 assembler (we'll use Z88DK or SJASM)
- Text editor of your choice

## 2. Creating a New Program

### Step 1: Create Source File
1. Navigate to the `src` directory
2. Create a new file with `.asm` extension (e.g., `mygame.asm`)
3. Start with this basic template:

```asm
; My ZX Spectrum Program
; File: src/mygame.asm

    org 32768           ; Start at 32768 (usual place for machine code)

start:
    ; Your program code here
    ret                 ; Return to BASIC

; Data section
data:
    ; Your data here
```

### Step 2: Write Your Program
- Use Z80 assembly instructions
- Common ROM routines:
  - `5633` - Open channel
  - `8252` - Print string
  - `3435` - Clear screen
- Example program structure:
  1. Initialize
  2. Main loop
  3. Data section

### Step 3: Assemble Your Program
1. Install an assembler (Z88DK or SJASM)
2. Assemble your program:
```bash
# Using Z88DK
zcc +zx -lndos -create-app mygame.asm -o mygame.tap

# Using SJASM
sjasm mygame.asm mygame.bin
```

## 3. Running Your Program

### Using the run.sh Script
1. Make sure your program is in the correct format (.tap or .bin)
2. Use the run script with appropriate options:

```bash
# Basic run
./run.sh mygame.tap

# Run with specific model
./run.sh -m 128k mygame.tap

# Run as tape
./run.sh -t mygame.tap

# Run with debug
./run.sh -d mygame.tap
```

### Manual Running
1. Open ZEsarUX
2. Load your program:
   - For .tap files: Use the tape menu
   - For .bin files: Use the quickload option
3. Press F1 to start emulation

## 4. Debugging

### Using Debug Mode
1. Run with debug flag:
```bash
./run.sh -d mygame.tap
```
2. Use ZEsarUX debug features:
   - Breakpoints
   - Memory viewer
   - Register inspection
   - Step-by-step execution

### Common Debugging Techniques
1. Add breakpoints at critical points
2. Monitor memory locations
3. Check register values
4. Use the debugger's step function

## 5. Best Practices

### Code Organization
1. Keep your code modular
2. Use meaningful labels
3. Comment your code thoroughly
4. Separate data from code

### Memory Management
1. Be aware of memory locations
2. Don't overwrite system variables
3. Use appropriate ORG statements
4. Manage stack carefully

### Performance Tips
1. Use registers efficiently
2. Minimize memory access
3. Optimize loops
4. Use ROM routines when possible

## 6. Resources

### Documentation
- [Z80 Instruction Set](https://worldofspectrum.org/faq/reference/z80reference.htm)
- [ZX Spectrum ROM Routines](https://worldofspectrum.org/ZXBasicManual/zxmanchap24.html)
- [ZEsarUX Documentation](https://github.com/chernandezba/zesarux/wiki)

### Tools
- [Z88DK](https://github.com/z88dk/z88dk)
- [SJASM](https://github.com/Konamiman/Sjasm)
- [ZEsarUX](https://github.com/chernandezba/zesarux)

## 7. Example Programs

### Hello World
```asm
; Hello World Program
    org 32768

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
```

### Simple Game Loop
```asm
; Simple Game Loop
    org 32768

start:
    call 3435           ; Clear screen

game_loop:
    ; Game logic here
    call read_keys      ; Read keyboard
    call update_game    ; Update game state
    call draw_screen    ; Draw screen
    
    jr game_loop        ; Loop forever

; Subroutines
read_keys:
    ; Keyboard reading code
    ret

update_game:
    ; Game update code
    ret

draw_screen:
    ; Screen drawing code
    ret
``` 