FROM ubuntu:22.04

LABEL maintainer="x2031"
LABEL description=".net基础环境镜像"

ENV TZ=Asia/Shanghai

USER root
RUN sudo apt update
RUN sudo apt install -y wget curl  sshpass  openssh-client
RUN sudo apt install -y openjdk-17-jre

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
#安装node
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN sudo apt-get install -y nodejs
RUN npm install -g npm
RUN sudo apt-get install -y  dotnet-sdk-6.0
RUN sudo apt-get install -y  dotnet-sdk-8.0
RUN dotnet tool install ElectronNET.CLI -g

RUN dpkg --add-architecture i386
RUN mkdir -pm755 /etc/apt/keyrings
RUN sudo wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
RUN sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
RUN sudo apt update
RUN sudo apt install  -y --install-recommends winehq-stable
RUN sudo apt install  -y --install-recommends winehq-stable wine-stable-amd64


#清理垃圾
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
