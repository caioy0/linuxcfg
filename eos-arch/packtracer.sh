#!/usr/bin/zsh

#2025-03-15

printf "2025-03-15 arch-linux packet tracer installer.\n"
printf "Before the install, you need to Download the packettracer.deb in Official Cisco web site.\n0-To exit \n1 - Start the build \n2- Download page.\n "
printf "3- quick exec script \n"
read -r option
if [[ "$option" == "1" ]]; then

    #Install packettracer
    if [[ ! -d "$HOME/packettracer" ]]; then
        git clone https://aur.archlinux.org/packettracer.git "$HOME/packettracer"
    fi

    #install .deb package
    cd $HOME/packettracer

    printf "CHROOT NOT READY\n"
    printf "Chroot build?\n [Y or n]?"
    read -r choice

    if [["$choice" == "Y" || "$choice" == "y"]]; then
        if ! cat ~/chroot; then
            mkdir ~/chroot
            CHROOT=$HOME/chroot
            mkarchroot $CHROOT/ROOT base-devel
            if ! cat ~/.makepgk.conf; then 
                cat > ~/.makepg.conf <<EOL
EOL
            fi
            if ! grep "mirrorlist" $CHROOT/root/etc/pacman.d/mirrorlist; then
                printf "not ready chroot\n"
                exit 0
            fi
        else
            printf "not ready chroot\n"
            exit 0
        fi
    elif [["$choice" == "N" || "$choice" == "n"]]; then
        printf "no chroot install"\n 
        sleep 1
        mv ~/Donwloads/Packet_Tracer822_amd64_signed.deb ~/packettracer
        sudo pacman -S --noconfirm qt5-multimedia qt5-webengine qt5-svg qt5-networkauth qt5-websockets qt5-script qt5-speech jdk17-openjdk
        makepkg
        printf "Now build the package using: sudo pacman -U file\n"
    else
        printf "Invalid input!\n"
    fi
        
elif [["$option" == "2"]]; then
    printf "You need to login/register at cisco network site, and download the file .deb.\n"
    printf "Link: https://skillsforall.com/resources/lab-downloads\n"

elif [["$option" == "3"]]; then
    cd $HOME/packettracer
    makepkg
    sudo pacman -U ./Packet_Tracer822_amd64_signed.tar.gz

elif [["$option" == "0"]]; then
    printf "Goodbye!"
    exit 0
else
    printf "Input not valid\n"
fi
printf "Finished!\n"