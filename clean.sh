#!/bin/bash

set -e

echo "env cleanup"
echo "======================================="
echo ""

if [ -d "dosbox-c" ]; then
    rm -rf dosbox-c
    echo "dosbox-c directory removed"
fi

if [ -f "hp95lx.conf" ]; then
    rm -f hp95lx.conf
    echo "hp95lx.conf file removed"
fi

echo ""
echo "done"