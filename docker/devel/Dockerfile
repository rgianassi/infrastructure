# syntax=docker/dockerfile:1
FROM ubuntu:latest
LABEL version="0.1.0" \
    description="Base working image in a docker container" \
    maintainer="Roberto GIANASSI <roberto.gianassi+github.com@gmail.com>" \
    source="https://vivaldi.com/"

ARG user
ARG uid
ARG gid

ENV USERNAME ${user}
ENV HOME /home/${user}

RUN apt-get update
RUN apt install -y sudo wget gnupg2 software-properties-common ca-certificates

RUN useradd -m ${USERNAME} \
    && echo "${USERNAME}:${USERNAME}" | chpasswd \
    && usermod --shell /bin/bash ${USERNAME} \
    && usermod --uid ${uid} ${USERNAME} \
    && groupmod --gid ${gid} ${USERNAME}

RUN sudo usermod -a -G audio ${USERNAME}
RUN sudo usermod -a -G video ${USERNAME}

RUN wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | apt-key add -
RUN add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'

RUN apt-get update

RUN apt install -y vivaldi-stable

RUN apt install -y binutils curl tar xz-utils fonts-noto
RUN apt install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev \
    libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb \
    x11-apps build-essential ca-certificates libcurl3-gnutls \
    libcurl4 libcurl4-openssl-dev mesa-utils mesa-utils-extra \
    v4l-utils guvcview ffmpeg
RUN echo "roberto ALL=(root) NOPASSWD: /etc/init.d/dbus" > /etc/sudoers.d/dbus
RUN apt install -y libasound2-plugins
RUN echo cGNtLmRlZmF1bHQgcHVsc2UKY3RsLmRlZmF1bHQgcHVsc2UK | base64 -d > /etc/asound.conf
RUN /opt/vivaldi/update-ffmpeg

COPY docker.init.sh ${HOME}/docker.init.sh
RUN chown ${USERNAME}:${USERNAME} ${HOME}/docker.init.sh
RUN chmod +x ${HOME}/docker.init.sh

RUN adduser ${USERNAME} sudo

USER ${USERNAME}
WORKDIR ${HOME}

RUN ${HOME}/docker.init.sh
