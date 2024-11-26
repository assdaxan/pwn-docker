FROM ubuntu:24.04

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt -y upgrade && apt -y autoremove
RUN apt install -y ca-certificates

RUN sed -ie 's/http:\/\/archive.ubuntu.com/https:\/\/mirror.kakao.com/g' /etc/apt/sources.list
RUN sed -ie 's/http:\/\/security.ubuntu.com/https:\/\/mirror.kakao.com/g' /etc/apt/sources.list

RUN dpkg --add-architecture i386
RUN apt update && apt -y upgrade && apt -y autoremove
RUN apt install -y  build-essential \
                    python3 \
                    python3-pip \
                    python3-dev \
                    python3-venv \
                    git \
                    vim \
                    wget \
                    tmux \
                    net-tools \
                    tar \
                    ssh \
                    openssh-server \
                    sudo \
                    curl \
                    htop \
                    dnsutils

RUN apt install -y  gdb \
                    libc6-dbg \
                    libc6-dbg:i386 \
                    libc6:i386 \
                    libncurses6:i386 \
                    libstdc++6:i386

RUN /bin/sh -c pip3 install --upgrade pip

RUN pip3 install    pwntools \
                    requests \
                    ROPGadget \
                    capstone \
                    one_gadget \
                     --break-system-packages

RUN echo "set number\nset smartindent\nset shiftwidth=4\nsyntax on" >> /etc/vim/vimrc

COPY ./peda-init.sh /peda-init.sh
RUN chmod o+x /peda-init.sh

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh
