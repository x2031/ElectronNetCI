FROM ubuntu:22.04

LABEL maintainer="x2031"
LABEL description=".net基础环境镜像"

USER root

RUN apt-get update && apt-get install -y && \   
    apt-get install -y wget curl gnupg
# install dotnet
RUN wget -O ./dotnet-install.sh https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh
RUN chmod +x ./dotnet-install.sh
RUN ./dotnet-install.sh --channel LTS
#安装node
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    apt-get install -y nodejs \
    npm config set registry https://registry.npmmirror.com \
    npm install -g npm
RUN dotnet tool install ElectronNET.CLI -g

#清理垃圾文件
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
