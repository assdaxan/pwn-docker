#!/bin/bash

create_user() {
    if [ -z "${USER_ID}" ]; then
        USER_ID="user"
    fi

    if ! grep -q '^'${USER_ID}':' /etc/passwd; then
        echo "create account : " ${USER_ID}
        /usr/sbin/useradd -m -s /bin/bash ${USER_ID}
    else
        echo "exists user account : " ${USER_ID}
    fi

    if [ -n "${FILE__SUDO_PASSWORD}" ]; then
        export SUDO_PASSWORD=$(cat ${FILE__SUDO_PASSWORD})
        chmod 0660 ${FILE__SUDO_PASSWORD}
    fi

    if [ -n "${SUDO_PASSWORD}" ]; then
        echo "setting up sudo access"
        if ! grep -q ${USER_ID} /etc/sudoers; then
            echo "adding " ${USER_ID} " to sudoers"
            echo ${USER_ID} " ALL=(ALL:ALL) ALL" >> /etc/sudoers
        fi

        echo "setting sudo password using SUDO_PASSWORD env var"
        echo -e "${SUDO_PASSWORD}\n${SUDO_PASSWORD}" | passwd ${USER_ID}
    fi
}

create_user
su -c /peda-init.sh - ${USER_ID}

service ssh start 
/bin/bash
