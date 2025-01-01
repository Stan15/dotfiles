docker run --rm -d \
  --name=chromium-cobrowse \
  -e VNC_PW=password \
  -e APP_ARGS="--remote-debugging-port=9222" \
  --shm-size="1gb" \
  --network=host \
  --device /dev/dri:/dev/dri \
  kasmweb/chromium:1.14.0  
