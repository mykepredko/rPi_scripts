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

echo_yellow "sudo apt update -y"
sudo apt update -y
echo_yellow "sudo apt list --upgradable -y"
sudo apt list --upgradable -y
echo_yellow "sudo apt full-upgrade -y"
sudo apt full-upgrade -y
echo_yellow "sudo apt install git -y"
sudo apt install git -y
