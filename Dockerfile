FROM ubuntu:23.10

LABEL maintainer="x2031"
LABEL description=".net基础环境镜像"

ENV TZ=Asia/Shanghai

USER root
RUN apt-get update && apt-get install -y && \
    apt-get install -y wget curl gnupg apt-transport-https 

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
#安装node
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    apt-get install -y nodejs \
    npm config set registry https://registry.npmmirror.com
RUN npm install -g npm
RUN apt-get install -y  dotnet-sdk-6.0 \
    apt-get install -y  dotnet-sdk-8.0
RUN dotnet tool install ElectronNET.CLI -g

RUN dpkg --add-architecture i386 \
    mkdir -pm755 /etc/apt/keyrings \
    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/mantic/winehq-mantic.sources \
    apt update \
    apt install  -y --install-recommends winehq-stable \
    apt install  -y --install-recommends winehq-stable wine-stable-amd64


#清理垃圾文件
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
