#!/bin/bash

# Watch all miner logs in real-time with prefixes

# Check if log files exist
if [ ! -f ccminer-x2.log ] && [ ! -f ccminer-a710.log ] && [ ! -f ccminer-a510.log ]; then
    echo "Error: No log files found. Start miners first with ./start-miner.sh"
    exit 1
fi

# Create log files if they don't exist yet
touch ccminer-x2.log ccminer-a710.log ccminer-a510.log 2>/dev/null

echo "======================================="
echo "Watching all miner logs..."
echo "Press Ctrl+C to exit"
echo "======================================="
echo ""

# Follow all three log files and prefix each line with the core type
tail -F ccminer-x2.log ccminer-a710.log ccminer-a510.log 2>/dev/null | \
    sed -u -e 's/^==> ccminer-x2.log <==/\n[X2 Core]/' \
           -e 's/^==> ccminer-a710.log <==/\n[A710 Cores]/' \
           -e 's/^==> ccminer-a510.log <==/\n[A510 Cores]/'

