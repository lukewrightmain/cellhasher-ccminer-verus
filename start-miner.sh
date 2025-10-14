#!/bin/bash

# Verus Mining Launcher - Runs optimized miners on all core types
# X2 (1 core) + A710 (3 cores) + A510 (4 cores) = 8 threads total

POOL="stratum+tcp://us.vipor.net:5040"
WALLET="RQJGcvqboXdDme3r2VKzaYViUnj6P8yQJz"

echo "Starting Verus miners on all cores..."
echo "======================================="

# Kill any existing ccminer processes
pkill -f ccminer 2>/dev/null
sleep 1

# Start X2 miner (core 7) - 1 thread
echo "Starting X2 miner on core 7 (1 thread)..."
taskset -c 7 ./ccminer-x2 -a verus -o $POOL -u ${WALLET}.X2 -t 1 > ccminer-x2.log 2>&1 &
X2_PID=$!
echo "  X2 PID: $X2_PID"

sleep 1

# Start A710 miner (cores 4-6) - 3 threads
echo "Starting A710 miner on cores 4-6 (3 threads)..."
taskset -c 4-6 ./ccminer-a710 -a verus -o $POOL -u ${WALLET}.A710 -t 3 > ccminer-a710.log 2>&1 &
A710_PID=$!
echo "  A710 PID: $A710_PID"

sleep 1

# Start A510 miner (cores 0-3) - 4 threads
echo "Starting A510 miner on cores 0-3 (4 threads)..."
taskset -c 0-3 ./ccminer-a510 -a verus -o $POOL -u ${WALLET}.A510 -t 4 > ccminer-a510.log 2>&1 &
A510_PID=$!
echo "  A510 PID: $A510_PID"

echo ""
echo "======================================="
echo "All miners started!"
echo "PIDs: X2=$X2_PID A710=$A710_PID A510=$A510_PID"
echo ""
echo "Log files:"
echo "  X2:   ccminer-x2.log"
echo "  A710: ccminer-a710.log"
echo "  A510: ccminer-a510.log"
echo ""
echo "To watch all logs: ./watch-logs.sh"
echo "To stop all miners: ./stop-miner.sh"
echo "To check status: ps aux | grep ccminer"
echo "======================================="

