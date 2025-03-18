#!/usr/bin/zsh

#2025-03-15

printf("2025-03-15 arch-linux packet tracer installer.\n")
printf("Before the install, you need to Donwload the packettracer.deb in Official Cisco web site.\n0-To exit \n1 - Start the build \n2- Download page.\n")
read -r option
if [[$option == "1"]]

    #Install packettracer
    if ! cd ~/packettracer; then
        cd
        git clone https://aur.archlinux.org/packettracer.git
    fi
    #install .deb package
    cd ~/packettracer

    printf("Chroot build?"\n Y or n?)
    read -r choice

    if [[$choice == "Y" || $choice == "y"]]; then
        if ! cat ~/chroot; then
            mkdir ~/chroot
            CHROOT=$HOME/chroot
            mkarchroot $CHROOT/ROOT base-devel
            if ! cat ~/.makepgk.conf; then 
                cat > ~/.makepg.conf <<EOL
EOL
            fi
            if ! grep "mirrorlist" $CHROOT/root/etc/pacman.d/mirrorlist; then
                printf("not ready chroot")
                exit 0
            fi
        else
            printf("not ready chroot")
            exit 0
        fi
    else
        printf("no chroot install"\n)
        mv ~/Donwloads/Packet_Tracer822_amd64_signed.deb ~/packettracer
        sleep 2
        makepkg
    fi
        
elif [[$option == "2"]]
    printf("You need to login/register in cisco network\n")
    printf("Link: https://skillsforall.com/resources/lab-downloads\n")
elif [[$option == "3"]]
    printf("Goodbye!")
    exit 0
else
    printf("Input not valid\n")
fi
