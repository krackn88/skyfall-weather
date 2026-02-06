#!/bin/bash
# Open port 8765 for network access - run with: sudo ./open-firewall.sh
PORT=8765

echo "Opening port $PORT for the weather app..."

if command -v ufw &>/dev/null; then
  ufw allow $PORT/tcp 2>/dev/null && ufw reload 2>/dev/null
  echo "Done (ufw). Port $PORT is now allowed."
elif command -v firewall-cmd &>/dev/null; then
  firewall-cmd --permanent --add-port=$PORT/tcp 2>/dev/null
  firewall-cmd --reload 2>/dev/null
  echo "Done (firewalld). Port $PORT is now allowed."
else
  echo "No ufw or firewalld found. If you use iptables, run:"
  echo "  sudo iptables -I INPUT -p tcp --dport $PORT -j ACCEPT"
fi
