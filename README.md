# Games for HP 95LX Palmtop

A small set of apps designed to work on the HP 95LX Palmtop PC (model F1000A) running MS-DOS 3.22.

## Setup

### Requirements

- DOSBox-X (latest version recommended)
  - Download from: https://dosbox-x.com/
  - Working with ver. 2025.12.01 64 bit
- Turbo Pascal 3.02a compile files
  - See `tp` directory for more info

### Setup Instructions
> Currently only tested on Windows with DOSBox-X, other platforms will need to manually create the configuration file based on `setup.sh` script.

#### Windows

After requirements are met, run
```bash
./setup.sh
```

This will create a DOSBox-X configuration file `hp95lx.conf` in the current directory and give you a command to launch the dosbox with it.
