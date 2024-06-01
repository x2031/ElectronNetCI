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

RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update

RUN apt-get install -y dotnet-sdk-8.0 dotnet-sdk-6.0
RUN cd /usr/share/dotnet/shared/Microsoft.NETCore.App/ && \
    ls 
RUN cd /usr/lib/dotnet/shared/Microsoft.NETCore.App/ && \
    ls     
RUN echo 'export PATH="$PATH:/usr/bin/dotnet"' >> ~/.bashrc
RUN echo 'export PATH="$PATH:/root/.dotnet/tools"' >> ~/.bashrc
RUN dotnet tool install ElectronNET.CLI -g
#清理垃圾文件
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
