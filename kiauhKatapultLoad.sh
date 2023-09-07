#! /bin/bash

# Automate the KIAUH & Katapult Load at the start of the Klipper Setup Process
# Code is for Controller Boards with CAN interfaces, namely:
# BTT Manta M5P/M8P
# BTT Octopus/Octopus Pro
# MKS Monster8

# Written by: myke predko
# Last Update: 2023.09.07

# Questions and problems to be reported at https://klipper.discourse.group

# This software has only been tested on BTT Octopus and BTT Manta M8P

# Users of this software run at their own risk as this software is "As Is" with no Warranty or Guarantee.  


# Echo Colour Specifications
echoGreen(){
  echo -e "\e[32m${1}\e[0m"
}
echoRed(){
  echo -e "\e[31m${1}\e[0m"
}
echoBlue(){
  echo -e "\e[34m${1}\e[0m"
}
echoYellow(){
  echo -e "\e[33m${1}\e[0m"
}


echoYellow "Klipper KIAUH & Katapult Install"

sudo apt install git -y

cd ~
git clone https://github.com/th33xitus/kiauh.git

cd ~
git clone https://github.com/Arksine/Katapult

pip3 install pyserial

echoYellow "KIAUH & Katapult Installation Complete"

# Try starting up KIAUH before leaving
./kiauh/kiauh.sh
