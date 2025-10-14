#!/bin/bash

# Show mining statistics summary for all miners

echo "======================================="
echo "Verus Mining Statistics"
echo "======================================="
echo ""

# Function to extract last hashrate from log
get_hashrate() {
    local logfile=$1
    local corename=$2
    
    if [ ! -f "$logfile" ]; then
        echo "$corename: NOT RUNNING (log file not found)"
        return
    fi
    
    # Look for hashrate lines (common formats: "hash rate: X.XX" or "Hashrate: X.XX")
    local hashrate=$(tail -n 50 "$logfile" 2>/dev/null | grep -i "hash" | tail -n 1)
    
    if [ -z "$hashrate" ]; then
        echo "$corename: Running but no hashrate data yet"
    else
        echo "$corename: $hashrate"
    fi
}

# Function to count accepted shares
get_shares() {
    local logfile=$1
    if [ ! -f "$logfile" ]; then
        echo "0"
        return
    fi
    grep -c -i "accepted\|yes!" "$logfile" 2>/dev/null || echo "0"
}

# Get hashrates
echo "=== Hashrates ==="
get_hashrate "ccminer-x2.log" "X2 (1 core) "
get_hashrate "ccminer-a710.log" "A710 (3 cores)"
get_hashrate "ccminer-a510.log" "A510 (4 cores)"

echo ""
echo "=== Accepted Shares ==="
X2_SHARES=$(get_shares "ccminer-x2.log")
A710_SHARES=$(get_shares "ccminer-a710.log")
A510_SHARES=$(get_shares "ccminer-a510.log")
TOTAL_SHARES=$((X2_SHARES + A710_SHARES + A510_SHARES))

echo "X2:   $X2_SHARES shares"
echo "A710: $A710_SHARES shares"
echo "A510: $A510_SHARES shares"
echo "---"
echo "Total: $TOTAL_SHARES shares"

echo ""
echo "=== Process Status ==="
if pgrep -f ccminer-x2 > /dev/null; then
    echo "X2:   ✓ Running (PID: $(pgrep -f ccminer-x2))"
else
    echo "X2:   ✗ Not running"
fi

if pgrep -f ccminer-a710 > /dev/null; then
    echo "A710: ✓ Running (PID: $(pgrep -f ccminer-a710))"
else
    echo "A710: ✗ Not running"
fi

if pgrep -f ccminer-a510 > /dev/null; then
    echo "A510: ✓ Running (PID: $(pgrep -f ccminer-a510))"
else
    echo "A510: ✗ Not running"
fi

echo ""
echo "======================================="
echo "To watch live logs: ./watch-logs.sh"
echo "======================================="

