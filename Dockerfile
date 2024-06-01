FROM ubuntu:22.04

LABEL maintainer="x2031"
LABEL description=".net基础环境镜像"

USER root

RUN apt-get update && apt-get install -y && \   
    apt-get install -y wget curl gnupg apt-transport-https
#安装node
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - 
RUN apt-get install -y nodejs
RUN npm config set registry https://registry.npmmirror.com
RUN npm install -g npm

RUN wget -q https://packages.microsoft.com/config/$ID/$VERSION_ID/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    dpkg -i packages-microsoft-prod.deb \
    apt-get update

RUN apt-get install -y dotnet-sdk-8.0
RUN dotnet tool install ElectronNET.CLI -g

#清理垃圾文件
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
