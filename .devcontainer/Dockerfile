FROM ubuntu:22.04

USER root

# 必要なパッケージのインストール
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion sudo \
    curl build-essential

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y software-properties-common tzdata wget ninja-build jq
RUN apt-get update && apt-get install -y language-pack-ja && \
    update-locale LANG=ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

# fishシェルのインストール
RUN apt-add-repository ppa:fish-shell/release-3 && \
    apt-get update && \
    apt-get install -y fish

# Typst のインストール
RUN curl -fsSL https://github.com/typst/typst/releases/download/v0.12.0/typst-x86_64-unknown-linux-musl.tar.xz | tar -xJ && \
    mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/ && \
    rm -rf typst-x86_64-unknown-linux-musl

# 原ノ味フォント（Harano Aji Fonts）のインストール
RUN mkdir -p /usr/local/share/fonts/harano-aji && \
    cd /usr/local/share/fonts/harano-aji && \
    (wget http://mirrors.ibiblio.org/CTAN/fonts/haranoaji.zip || \
     wget https://mirrors.sustech.edu.cn/CTAN/fonts/haranoaji.zip || \
     wget https://mirrors.sdu.edu.cn/CTAN/fonts/haranoaji.zip) && \
    unzip haranoaji.zip && \
    find . -name "*.otf" -exec cp {} /usr/local/share/fonts/harano-aji/ \; && \
    rm -rf haranoaji.zip && \
    fc-cache -fv

# Node.js 20.xのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# ユーザーの追加
ARG USER=developer
RUN useradd -m -s /bin/bash ${USER} && \
    echo "${USER}:${USER}" | chpasswd && \
    usermod -aG sudo ${USER}

WORKDIR /root/workspace

# package.jsonをコピーしてNode.js依存関係をインストール
COPY package*.json ./
RUN npm install

# ソースコードをコピー
COPY . .