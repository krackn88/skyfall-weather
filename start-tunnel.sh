#!/bin/bash
# Kill everything, then run serve-tunnel in external terminal
cd "$(dirname "$0")"

echo "Stopping any existing servers and tunnels..."
fuser -k 8765/tcp 2>/dev/null
pkill -f "serve-tunnel" 2>/dev/null
pkill -f "cloudflared" 2>/dev/null
pkill -f "http-server.*8765" 2>/dev/null
pkill -f "localtunnel" 2>/dev/null
sleep 2

MAP_DIR="$(cd "$(dirname "$0")" && pwd)"
gnome-terminal -- bash -c "cd '$MAP_DIR' && ./serve-tunnel.sh; exec bash"
