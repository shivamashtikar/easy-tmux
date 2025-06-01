#!/bin/bash

ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Now open tmux and press Ctrl+b I"
