# pwn-docker
pwnable에 사용 가능한 기본적인 도구를 포함한 도커 파일 입니다.

### 환경변수
---
사용자는 user.env 파일에 초기 사용자 정보를 정의해야 합니다. </br>
패스워드를 정의할 수 있는 방법은 2가지이며, SUDO_PASSWORD, FILE__SUDO_PASSWORD 중 1개만 택해야 한다. </br>
만약 FILE__SUDO_PASSWORD 변수를 사용하는 경우 docker-compose.yml에서 volumes에 패스워드가 저장된 폴더를 정의해줘야 한다.

|변수|내용|
|:---|:---|
|USER_ID|사용자 아이디|
|SUDO_PASSWORD|사용자 패스워드|
|FILE__SUDO_PASSWORD|사용자 패스워드를 저장하는 파일 (옵션) |

user.env : 
```
USER_ID=ID
SUDO_PASSWORD=PASSWORD
#FILE__SUDO_PASSWORD=/path/file

```

### 기본 설치 모듈
---
이 도커 파일은 아래 정의된 프로그램, 모듈이 설치됩니다. </br>
만약 프로그램, 모듈을 추가/제거하기 위해서는 Dockerfile을 수정해야 합니다.
```
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
```

### SSH 접속 포트
---
위 도커는 외부 접속을 위해 5561번 포트를 개방하고 있습니다. </br>
만약 외부 접속을 원하지 않는다면 docker-compose.yml 내부에 정의된 ports 정보를 수정하십시오.
```
0.0.0.0:5561 -> 22/tcp
```

connect : 
```
ssh [USER_ID]@[IP] -p 5561
```

### 실행
---
docker-compose를 이용하여 쉽게 실행할 수 있습니다.

run : 
```
docker-compose up -d
```
