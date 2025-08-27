#!/bin/bash

# Test script per verificare che i comandi stop-servers e kill-port funzionino

echo "🧪 Testing server management commands..."
echo

# Test 1: Avvia server in background
echo "1️⃣ Starting Waitress server in background..."
cd /Users/massi/progetti/deploy-django
make waitress &
SERVER_PID=$!
echo "   Server started with PID: $SERVER_PID"
sleep 3

# Test 2: Verifica che il server sia attivo
echo
echo "2️⃣ Checking if server is running..."
if ps aux | grep -E "(waitress.*wsgi)" | grep -v grep > /dev/null; then
    echo "   ✅ Server is running"
else
    echo "   ❌ Server is not running"
    exit 1
fi

# Test 3: Testa stop-servers
echo
echo "3️⃣ Testing stop-servers command..."
make stop-servers

# Test 4: Verifica che il server sia stato fermato
echo
echo "4️⃣ Checking if server was stopped..."
sleep 2
if ps aux | grep -E "(waitress.*wsgi)" | grep -v grep > /dev/null; then
    echo "   ❌ Server is still running"
    echo "   🔪 Using kill-port as fallback..."
    make kill-port
else
    echo "   ✅ Server was stopped successfully"
fi

echo
echo "🎉 Test completed!"
