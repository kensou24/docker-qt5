FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="kensou"

# title
ENV TITLE=Qt5

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/chromium-logo.png && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y fonts-noto-cjk && \
  apt-get install -y --no-install-recommends \
    qtbase5-dev \
    qt5-qmake \
    build-essential \
    libqt5widgets5 \
    libqt5gui5 \
    libqt5network5 \
    libqt5serialport5-dev \
    libqt5serialport5 \
    libqt5charts5-dev \
    libqt5charts5 &&\ 
  apt-get install -y --no-install-recommends qtcreator --fix-missing && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
