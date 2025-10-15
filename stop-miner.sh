#!/bin/bash

# Stop all ccminer processes

echo "Stopping all ccminer processes..."
pkill -f ccminer

sleep 1

# Check if any are still running
if pgrep -f ccminer > /dev/null; then
    echo "Warning: Some ccminer processes still running. Force killing..."
    pkill -9 -f ccminer
    sleep 1
fi

if ! pgrep -f ccminer > /dev/null; then
    echo "All miners stopped successfully!"
else
    echo "Error: Could not stop all miners."
    ps aux | grep ccminer
fi

