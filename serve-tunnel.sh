#!/bin/bash
# Serve the weather app AND create a public tunnel - use when network PCs can't connect
# No password, no click-through - just open the URL
cd "$(dirname "$0")"
PORT=8765

# Kill anything on our port
fuser -k $PORT/tcp 2>/dev/null
sleep 1

# Start server in background
echo "Starting server on port $PORT..."
python3 -m http.server $PORT --bind 0.0.0.0 &
SERVER_PID=$!
sleep 2

# Cleanup on exit
cleanup() { kill $SERVER_PID 2>/dev/null; exit 0; }
trap cleanup INT TERM

# Find cloudflared (system or downloaded)
CLOUDFLARED=$(which cloudflared 2>/dev/null || [ -x /tmp/cloudflared ] && echo /tmp/cloudflared || echo "")

if [ -z "$CLOUDFLARED" ]; then
  echo "Installing cloudflared..."
  curl -sL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /tmp/cloudflared
  chmod +x /tmp/cloudflared
  CLOUDFLARED=/tmp/cloudflared
fi

# Start tunnel (Cloudflare - no password, no prompts)
echo ""
echo "Creating tunnel (no password needed)..."
echo ""
echo "  ============================================"
echo "  Open this URL on your other PC or phone:"
echo "  ============================================"
$CLOUDFLARED tunnel --url http://localhost:$PORT
echo ""
echo "Tunnel closed. Stopping server."
cleanup
