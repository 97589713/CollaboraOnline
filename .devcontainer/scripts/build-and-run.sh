#!/bin/bash
set -e

echo "=== Building and Running Collabora Online ==="

# Build and run in background
cd /workspace/CollaboraOnline

# Start build and run process
echo "Starting make run..."
nohup make -j$(nproc) run > /tmp/collabora-build.log 2>&1 &

# Wait for port 9980 to be available
echo "Waiting for Collabora Online to start on port 9980..."
timeout=300
elapsed=0
while ! nc -z localhost 9980; do
    if [ $elapsed -ge $timeout ]; then
        echo "Timeout waiting for port 9980"
        echo "Last 50 lines of build log:"
        tail -50 /tmp/collabora-build.log
        exit 1
    fi
    sleep 5
    elapsed=$((elapsed + 5))
    echo "Still waiting... ($elapsed seconds)"
done

echo ""
echo "=== Collabora Online is ready! ==="
echo ""
echo "If you are not using the VS Code desktop and instead just your web browser, to open and test Collabora Online:"
echo "1. Make sure your web browser is not blocking any tabs from opening;"
echo "2. Check that you have the VNC tab opened (if not, open it up from the left side Remote explorer > 6080)"
echo "3. In the terminal where make is running: scroll and copy the URL ending with: hello-world.odt"
echo "4. In a new terminal execute the following:"
echo "   firefox [paste copied URL here]"
echo ""
echo "Build log available at: /tmp/collabora-build.log"
echo ""
