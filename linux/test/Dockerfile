FROM ubuntu:latest
RUN apt-get update && apt-get install -y sudo locales
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
USER docker
WORKDIR /home/docker
