#!/usr/bin/env bash

## Echo Colour Specifications
echo_green(){
    echo -e "\e[32m${1}\e[0m"
}
echo_red(){
    echo -e "\e[31m${1}\e[0m"
}
echo_blue(){
    echo -e "\e[34m${1}\e[0m"
}
echo_yellow(){
    echo -e "\e[33m${1}\e[0m"
}

echo_yellow sudo apt update
sudo apt update
echo_yellow sudo apt list --upgradable
sudo apt list --upgradable
echo_yellow sudo apt full-upgrade
sudo apt full-upgrade
echo_yellow sudo apt install git
sudo apt install git
