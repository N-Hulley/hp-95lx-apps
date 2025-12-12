#!/bin/bash

set -e

echo "Running cleanup..."
./clean.sh
echo ""

PROJECT_PATH=$(pwd)

if [[ "$PROJECT_PATH" == /c/* ]]; then
    PROJECT_PATH="C:${PROJECT_PATH:2}"
elif [[ "$PROJECT_PATH" == /mnt/c/* ]]; then
    PROJECT_PATH="C:${PROJECT_PATH:6}"
fi

PROJECT_PATH="${PROJECT_PATH//\//\\}"

echo "===================================="
echo ""
echo "Project path: $PROJECT_PATH"

# Check if DOSBox-X exists
DOSBOX_PATH="C:\\DOSBox-X\\dosbox-x.exe"
if [[ -f "/c/DOSBox-X/dosbox-x.exe" ]] || [[ -f "/mnt/c/DOSBox-X/dosbox-x.exe" ]] || [[ -f "C:/DOSBox-X/dosbox-x.exe" ]]; then
    echo "DOSBox-X found"
else
    echo "DOSBox-X not found in $DOSBOX_PATH"
    echo ""
    echo "Please install DOSBox-X:"
    echo "1. Download from: https://dosbox-x.com/"
    echo "2. Install to: C:\\DOSBox-X\\"
    echo "3. Run this script again"
    echo ""
    read -p "Press Enter to exit..."
    exit 1
fi

echo ""
echo "Creating hp95lx.conf..."

mkdir -p dosbox-c/internal

cat > hp95lx.conf << EOF
# DOSBox-X config for HP 95LX (F1000A)
# - CPU: NEC V20 (Intel 8088 clone) @ 5.37 MHz
# - RAM: 512KB (F1000A) or 1MB (F1010A)
# - ROM: 1MB with MS-DOS 3.22, Lotus 1-2-3 2.2, built-in apps
# - Display: 40×16 character text mode (viewport into 80×25 MDA buffer)
# - Graphics: 240×128 pixels monochrome (quarter-CGA/MDA resolution)
# - Character set: Code Page 850 (not standard CP437)
# - Storage: PCMCIA 1.0 Type II slot for SRAM cards
# - Connectivity: RS-232 serial, infrared port
# - Power: 2× AA batteries + CR2032 backup

[sdl]
fullscreen=false
fulldouble=false
fullresolution=original
windowresolution=640,320
output=surface
autolock=false

[dosbox]
machine=mda
# 95LX uses MDA
memsize=0.5

[render]
frameskip=0
aspect=true
scaler=none

[cpu]
core=normal
cputype=8086
# NEC V20 is an Intel 8088 clone 
cycles=1000
# Simulates ~5.37 MHz NEC V20 speed
cycleup=10
cycledown=20

[dos]
ver=3.3
# Closest to DOS 3.22 available in DOSBox-X
xms=false
ems=false
# 95LX doesn't have expanded/extended memory

[video]
vmemsize=0
# Minimal video memory for MDA

[autoexec]
@ECHO OFF
REM Mount temporary directory to copy files
MOUNT D $PROJECT_PATH\\src
REM Create C: drive as HP 95LX internal storage (subfolder only)
MOUNT C $PROJECT_PATH\\dosbox-c\\internal
C:
REM Clean up any existing NICK directories first
RD C:\NICK /S /Q >NUL 2>&1
RD C:\NICK2 /S /Q >NUL 2>&1
RD C:\NICK3 /S /Q >NUL 2>&1
REM Create fresh NICK directory
MD C:\NICK
REM Copy all files from development src to NICK folder
XCOPY D:\*.* C:\NICK\ /S /E /Y >NUL
REM Copy essential Turbo Pascal files to NICK folder
MOUNT E $PROJECT_PATH\\TP
COPY E:\TURBO.COM C:\NICK\TURBO.COM >NUL
COPY E:\TURBO.MSG C:\NICK\TURBO.MSG >NUL
REM Unmount temporary mounts
MOUNT -u D
MOUNT -u E
REM Add nick folder to PATH and change to it
SET PATH=C:\NICK;%PATH%
CD C:\NICK
ECHO.
ECHO ==========================================
ECHO  fake HP 95LX Palmtop (F1000A) env
ECHO ==========================================
ECHO.
ECHO Type HELP for available commands
ECHO.
MODE CON: COLS=40
EOF

echo "created: hp95lx.conf"
echo ""
echo "Next steps:"
echo "Start DOSBox-X: C:\DOSBox-X\dosbox-x.exe -conf $PROJECT_PATH\hp95lx.conf"