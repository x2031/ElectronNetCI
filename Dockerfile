FROM ubuntu:22.04

LABEL maintainer="x2031"
LABEL description=".net基础环境镜像"

USER root

RUN apt-get update && apt-get install -y && \   
    apt-get install -y wget curl gnupg
#安装node
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - 
RUN apt-get install -y nodejs
RUN npm config set registry https://registry.npmmirror.com
RUN npm install -g npm

RUN apt-get install -y dotnet-sdk-8.0
RUN dotnet tool install ElectronNET.CLI -g

#清理垃圾文件
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
