#!/bin/bash

echo "initializing peda gdb"
if [[ ! -d ~/peda ]]; then
    echo "Clone peda"
    git clone https://github.com/longld/peda.git ~/peda
fi

if [[ ! -d ~/Pwngdb ]]; then
    echo "Clone Pwngdb"
    git clone https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb
fi

if [[ ! -f ~/.gdbinit ]]; then
    echo "make ~/.gdbinit"
    cp ~/Pwngdb/.gdbinit ~/
fi
