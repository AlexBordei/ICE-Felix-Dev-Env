# ICE-Felix-Dev-Env

A clean, simple environment for ZX Spectrum programming on ICE Felix computers.

## Prerequisites

- ZEsarUX emulator installed in `/Applications`
  - If you get a security warning, run: `xattr -d com.apple.quarantine /Applications/ZEsarUX.app`

## Quick Start

This environment uses a single command script (`zx.sh`) to manage everything:

```bash
# Start the ZX Spectrum emulator
./zx.sh run

# Create a new BASIC program
./zx.sh basic mygame

# Create a new assembly program
./zx.sh asm mygraphics

# Show help
./zx.sh help
```

## Development Workflow

### BASIC Programming

1. Create a new BASIC program:
   ```
   ./zx.sh basic mygame
   ```

2. Start the emulator:
   ```
   ./zx.sh run
   ```

3. In ZEsarUX:
   - Go to File → Smart Load → Navigate to `src/mygame.bas`
   - The program will load and run automatically

4. Edit the `.bas` file in your favorite text editor, then reload in the emulator

### Assembly Programming

1. Create a new assembly program:
   ```
   ./zx.sh asm mygame
   ```

2. Start the emulator:
   ```
   ./zx.sh run
   ```

3. In ZEsarUX:
   - Go to Tools → Assembler
   - In the assembler, File → Load → Navigate to `src/mygame.asm`
   - Click "Assemble" then "Run"

## Directory Structure

- `src/` - Source code files (BASIC and assembly)
- `roms/` - ROM files and compiled binaries
- `docs/` - Documentation and resources

## Resources

- ZEsarUX emulator menu options:
  - File → Smart Load: Load BASIC or binary files
  - Tools → Assembler: Access the built-in assembler
  - Tools → Debug CPU: Access the debugger

- Documentation:
  - [ZEsarUX Manual](https://github.com/chernandezba/zesarux/wiki)
  - [ZX Spectrum BASIC Manual](https://worldofspectrum.org/ZXBasicManual/)
  - [Z80 Instruction Set](https://worldofspectrum.org/faq/reference/z80reference.htm) 