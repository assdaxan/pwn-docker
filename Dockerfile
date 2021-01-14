FROM ubuntu:20.04

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN sed -ie 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

RUN dpkg --add-architecture i386
RUN apt update && apt -y upgrade && apt -y autoremove
RUN apt install -y  build-essential \
                    python3 \
                    python3-pip \
                    python3-dev \
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
                    htop

RUN apt install -y  gdb \
                    libc6-dbg \
                    libc6-dbg:i386 \
                    libc6:i386 \
                    libncurses5:i386 \
                    libstdc++6:i386

RUN pip3 install --upgrade pip
RUN pip3 install    pwntools \
                    requests \
                    ROPGadget \
                    capstone \
                    one_gadget

RUN echo "set number\nset smartindent\nset shiftwidth=4\nsyntax on" >> /etc/vim/vimrc

RUN useradd -m -s /bin/bash ubun
USER ubun
WORKDIR /home/ubun

RUN git clone https://github.com/longld/peda.git
RUN git clone https://github.com/scwuaptx/Pwngdb.git
RUN cp ~/Pwngdb/.gdbinit ~/

USER root
ENTRYPOINT service ssh start && bash
