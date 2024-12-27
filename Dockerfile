FROM ubuntu:23.10

LABEL maintainer="x2031"
LABEL description=".net基础环境镜像"

ENV TZ=Asia/Shanghai

USER root
RUN apt-get update
RUN apt-get install -y wget curl  sshpass  openssh-client
RUN apt-get install -y openjdk-17-jre

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
#安装node
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm
RUN apt-get install -y  dotnet-sdk-6.0
RUN apt-get install -y  dotnet-sdk-8.0
RUN dotnet tool install ElectronNET.CLI -g

RUN dpkg --add-architecture i386
RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/mantic/winehq-mantic.sources
RUN apt update
RUN apt install  -y --install-recommends winehq-stable
RUN apt install  -y --install-recommends winehq-stable wine-stable-amd64


#清理垃圾
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
