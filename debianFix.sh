#! /bin/bash

# Automate the Debian Bullseye Bug causing Klipper to no longer find the printer board
# Based on process outlined the Klipper Discourse Announcement here: https://klipper.discourse.group/t/debian-bullseye-bug-causing-klipper-to-no-longer-find-the-printer-board/8231
# Step 1: Determine whether or not system is in need of the "Debian Fix"
# Step 2: If sources.lst does not have the last line update, add it
# Step 3: Look for NO_PUBKEY and make the Keys available for keying
# Step 4: Add the keys to keyserver
# Step 5: Install Bulseye Backports

# Written by: myke predko
# Last Update: 2023.09.07

# Questions and problems to be reported at https://klipper.discourse.group

# This software has only been tested on Raspberry Pi 4B and CM4

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


echoYellow "Debian Bug Check & Fix Script"

echoYellow "Loading UDEV Policy"
echoRed "This may take a few moments to complete"
debianValue=`sudo apt-cache policy udev | grep "  Installed\:" | sed 's/  Installed: //'`
debianErrorValue="247.3-7+rpi1+deb11u1"

sourcesListLastLine="deb http://ftp.debian.org/debian bullseye-backports main non-free contrib"
sourcesListContents=$(</etc/apt/sources.list)

sudoAptUpdateResult=""
sudoAptUpdatePUBKEY="NO_PUBKEY "

if [ "$debianErrorValue" = "$debianValue" ] 
then
  echoRed "Have Debian Bug"
  if echo "$sourcesListContents" | grep -q "$sourcesListLastLine"; then
    echoGreen "Sources.list has '$sourcesListLastLine'"
    echoGreen "Presume that corrective action already implemented."
  else
    echoYellow "Adding to Sources.list: 'sourcesListLastLine'"
    sudo sh -c 'echo "deb http://ftp.debian.org/debian bullseye-backports main non-free contrib" >> /etc/apt/sources.list'

    echoYellow "Doing 'sudo apt-get update'"
    echoRed "This may take a few moments to complete"
    sudoAptUpdateResult=`sudo apt-get update -y`
    if echo "$sudoAptUpdateResult" | grep -q "$sudoAptUpdatePUBKEY"; then
      sudoAptUpdateSubString=${sudoAptUpdateResult#*$sudoAptUpdatePUBKEY}
      sudoAptUpdateSubStringArray=($sudoAptUpdateSubString)
      echoYellow "Adding ${sudoAptUpdateSubStringArray[0]} to keyserver"
      sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${sudoAptUpdateSubStringArray[0]}
      echoYellow "Adding ${sudoAptUpdateSubStringArray[2]} to keyserver"
      sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${sudoAptUpdateSubStringArray[2]}

      echoYellow "Repeating 'sudo apt-get update'"
      echoRed "This may take a few moments to complete"
      sudo apt-get update -y
    fi
	
    echoYellow "Installing Bullseye backports"
    echoRed "This may take a few moments to complete"
    sudo apt install udev -t bullseye-backports -y
	
    #  Put in message for user to reboot	
    echo
    echoYellow "#####################"	
    echoYellow "###               ###"	
    echoYellow "###  sudo reboot  ###"	
    echoYellow "###               ###"	
    echoYellow "#####################"	
  fi
else
  echoGreen "Debian Bug Not Present"
fi
