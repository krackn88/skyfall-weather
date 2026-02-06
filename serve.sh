#!/bin/bash
# Serve the weather app on all network interfaces so you can access it from other devices
cd "$(dirname "$0")"
PORT=8765

# Try to open firewall (ufw) - run with sudo if needed
if command -v ufw &>/dev/null && ufw status 2>/dev/null | grep -q "Status: active"; then
  if ! ufw status 2>/dev/null | grep -q "$PORT"; then
    echo "  Opening firewall port $PORT (may need sudo)..."
    sudo ufw allow $PORT/tcp 2>/dev/null && echo "  Port opened." || echo "  Run: sudo ufw allow $PORT/tcp"
  fi
fi

# Get local IP (works on most Linux)
LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}')
if [ -z "$LOCAL_IP" ]; then
  LOCAL_IP=$(ip route get 1 2>/dev/null | grep -oP 'src \K\S+')
fi

echo ""
echo "  Weather app running at:"
echo "  - This machine:   http://localhost:$PORT"
echo "  - On your network: http://${LOCAL_IP:-0.0.0.0}:$PORT"
echo ""
echo "  If other devices can't connect (router may block device-to-device):"
echo "  - Run: ./serve-tunnel.sh  (creates a public URL that works from anywhere)"
echo "  Press Ctrl+C to stop."
echo ""

# Prefer http-server (handles concurrent connections, defaults to 0.0.0.0)
if command -v npx &>/dev/null; then
  npx --yes http-server -p $PORT -a 0.0.0.0 -c -1 .
else
  python3 -m http.server $PORT --bind 0.0.0.0
fi
