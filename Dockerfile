FROM ubuntu:23.10

LABEL maintainer="x2031"
LABEL description=".net基础环境镜像"

USER root

RUN apt-get update && apt-get install -y && \
    apt-get install -y wget curl gnupg apt-transport-https sshpass ssh
#安装node
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - 
RUN apt-get install -y nodejs
RUN npm config set registry https://registry.npmmirror.com
RUN npm install -g npm

# RUN wget -q https://packages.microsoft.com/config/ubuntu/23.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
# RUN dpkg -i packages-microsoft-prod.deb
# RUN apt-get update

RUN apt-get install -y  dotnet-sdk-6.0
RUN apt-get install -y  dotnet-sdk-8.0
RUN echo 'export PATH="$PATH:/usr/bin/dotnet"' >> ~/.bashrc
RUN echo 'export PATH="$PATH:/root/.dotnet/tools"' >> ~/.bashrc
RUN dotnet tool install ElectronNET.CLI -g

RUN dpkg --add-architecture i386
RUN    mkdir -pm755 /etc/apt/keyrings 
RUN    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key 
RUN    wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/mantic/winehq-mantic.sources 
RUN    apt update 
RUN    apt install  -y --install-recommends winehq-stable 
RUN    apt install  -y --install-recommends winehq-stable wine-stable-amd64


#清理垃圾文件
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
