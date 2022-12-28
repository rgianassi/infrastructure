#!/bin/sh

# see:
# https://github.com/mviereck/x11docker/wiki/Short-setups-to-provide-X-display-to-container
# for some hints

export DBUS_SYSTEM_BUS_ADDRESS='unix:path=/var/run/dbus/system_bus_socket'
export DBUS_SESSION_BUS_ADDRESS='unix:path=/var/run/dbus/system_bus_socket'

#xhost +local:$USER

sudo service dbus start

docker run \
    --rm \
    --privileged \
    --device /dev/dri \
    --device /dev/vga_arbiter \
    --device /dev/snd \
    --device /dev/video0 \
    --device /dev/video1 \
    --device /dev/video2 \
    --device /dev/video3 \
    --group-add audio \
    --group-add video \
    --group-add render \
    --ipc=host \
    --cap-drop=ALL \
    --security-opt=no-new-privileges \
    \
    -e DISPLAY=unix$DISPLAY \
    -e XAUTHORITY=/tmp/.docker.xauth \
    -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
    -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    -e DBUS_SYSTEM_BUS_ADDRESS=$DBUS_SYSTEM_BUS_ADDRESS \
    -e DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
    \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
    -v $(pwd)/Downloads:/home/$USER/Downloads \
    -v $(pwd)/.config:/home/$USER/.config \
    -v $(pwd)/.cache:/home/$USER/.cache \
    -v $(pwd)/.vivaldi:/home/$USER/.vivaldi \
    -v /etc/localtime:/etc/localtime \
    -v /dev/snd:/dev/snd \
    -v /dev/shm:/dev/shm \
    -v /var/run/dbus:/var/run/dbus \
    -v /run/dbus:/run/dbus \
    -v ~/.config/pulse/cookie:/home/$USER/.config/pulse/cookie:ro \
    -v /var/run/user/${UID}/pulse/native:/var/run/user/${UID}/pulse/native:ro \
    -v /dev/bus/usb:/dev/bus/usb \
    -v /dev/video0:/dev/video0 \
    -v /dev/video1:/dev/video1 \
    -v /dev/video2:/dev/video2 \
    -v /dev/video3:/dev/video3 \
    -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
    -v /run/udev/data:/run/udev/data:ro \
    -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
    \
    -it \
    \
    devel \
    \
    /bin/bash
