# HyprV4, The script that makes so that you make your life easier.
## Welcome to HyprV4!
### Purpose:

This script was created for easily install Hyprland, making your life more easy.
### Status:

This script is in **BETA**, Proceed with caution.
### Notes:
IMPORTANT - You need to install this on a fresh install of Arch.

### Installation:
Clone the project, go to the root of the project and run this command:

```
.\set-hypr
```

And you're ready to go!

### Manual Installation
If you want to do manual installation, here it is.

NOTES: You need to install yay! I don't know if this project will have an option where you can choose yay or paru, yay will be the default now.

#### NVIDIA: Do this if you have a nvidia card.
Run this command:

```
yay -Sy linux-headers linux-zen linux-zen-headers nvidia-dkms qt5-wayland qt5ct libva libva-nvidia-driver-git
```

Write this in /etc/mkinitcpio.conf:

```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

Run these command:

```
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
```

```
echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
```

OPTIONAL: Verify command.

```
cat /etc/modprobe.d/nvidia.conf
```

It should return:

```
options nvidia-drm modeset=1
```

Now reboot your system!

#### General:
Run this command:

```
yay -Sy hyprland kitty jq mako waybar-hyprland swww swaylock-effects \
wofi wlogout xdg-desktop-portal-hyprland swappy grim slurp thunar \
polkit-gnome python-requests pamixer pavucontrol brightnessctl bluez \
bluez-utils blueman network-manager-applet gvfs thunar-archive-plugin \
file-roller btop pacman-contrib starship ttf-jetbrains-mono-nerd \
noto-fonts-emoji lxappearance xfce4-settings sddm-git sddm-sugar-candy-git 
```

Or you can use the attached script | "set-hypr" | to install everything for you.
---
- #### | set-hypr | for hyprland aur version it slow for get new update but perfect to using daily
- #### For people using systemd-boot you can do this adding `nvidia_drm.modeset=1` to the end of `/boot/loader/entries/arch.conf`.
- #### For people update to hyprland-0.29.1 just add this line `WLR_RENDERER_ALLOW_SOFTWARE=1` to `/etc/environment`
---

<details>
  <summary><strong> How to use attached script? </strong></summary>

---
- Step 1
```
  git clone https://github.com/oniichanx/hyprv6.git
```
- Step 2
```
  cd hyprv6
```
- Step 3
```
  chmod +x set-hypr
```
```
  chmod +x set-hypr-git
```
- Step 4 run which one you wanna use `hypr or hypr-git`
```
  ./set-hypr
```
```
  ./set-hypr-git
```
- DONE
---
</details>
</details>

<details>
  <summary><strong> After Done  Install optional packages? </strong></summary>

---
- #### Any Nerd Fonts installed and used by your terminal emulator to display icon (Highly Recommended: JetBrains Mono, since most of the config using this font)

- You can use lime-desu script to download any Nerd Fonts (requires [fzf](https://github.com/junegunn/fzf)&[wget](https://archlinux.org/packages/extra/x86_64/wget))
```
sudo pacman -S fzf wget
```
- run this next when fzf & wget install done
```
bash -c "$(curl -Ls https://raw.githubusercontent.com/lime-desu/bin/main/nf-dl)"
```
---
- #### install all font manual
```
pacman -S ttf-dejavu ttf-liberation ttf-droid ttf-ubuntu-font-family noto-fonts noto-fonts-cjk ttf-font-awesome

yay -S ttf-gelasio-ib ttf-caladea ttf-carlito ttf-liberation-sans-narrow ttf-ms-fonts ttf-tlwg ttf-maple ttf-twemoji
```
---
- #### install apple fonts manual
```
git clone https://aur.archlinux.org/apple-fonts.git
cd apple-fonts
makepkg -si
```
---
- #### install obs-studio & font-manager
```
pacman -S obs-studio
yay -S font-manager
```
---
- #### install webcord it just discord but can sharing srceen on wayland&hyprland
```
git clone https://aur.archlinux.org/webcord.git
cd webcord
makepkg -si
```
---
- #### install AppImageLauncher for just use appimage
```
yay -S AppImageLauncher
```
---
- #### install imagemagick for custom neofetch with image like .png|.jpg|.gif (requires [neofetch config](https://github.com/oniichanx/neofetch))
```
sudo pacman -S imagemagick
```
---
- #### set default-web-browser to librewolf
```
xdg-settings set default-web-browser librewolf.desktop
```
---
- #### How to disable yay -debug
```
nano /etc/makepkg.conf
```
- and just put `!` in font debug to look like this `!debug`
---
- #### How to config muitdisplay easy way (requires [nwg-displays](https://github.com/nwg-piotr/nwg-displays))
```
yay -S nwg-displays
```
---
  </details>
</details>

<details>
  <summary><strong> How to make archlinux secure boot? (SYSTEMD-BOOT Only | GRUB not working)</strong></summary>

---
- Step 1
```
sudo pacman -S sbctl
```
- Step 2
```
sudo sbctl create-keys
```
- Step 3
```
sudo sbctl enroll-keys -m
```
- Step 4
```
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFi
sudo sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi
sudo sbctl sign -s /boot/vmlinuz-linux
sudo sbctl sign -s /boot/vmlinuz-linux-zen
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
```
- Step 5
```
sudo sbctl verify
```
- Done

---
  </details>
</details>

<details>
  <summary><strong> How to dual boot windows with archlinux? (GRUB) </strong></summary>
  
---
- Step 1
```
sudo pacman -S os-prober
```
- Step 2
```
sudo mkinitcpio -P
```
- Step 3 remove # on GRUB_DISABLE_OS_PEROBER=false
```
sudo nano /etc/default/grub
```
- Step 4
```
sudo grub-install --target=x86_64-efi --efi-directory=/efi --boot-directory=/efi --bootloader-id=GRUB
```
- or
```
sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --boot-directory=/mnt/boot
```
- Step 5
```
sudo grub-mkconfig -o /efi/grub/grub.cfg
```
- Done

---
  </details>
</details>

<details>
  <summary><strong> How to dual boot windows with archlinux? (SYSTEMD-BOOT) </strong></summary>
  
---
- Step 1 (note first efi partition block number)
```
sudo fdisk -l
```
- Step 2
```
sudo mkdir /mnt/windows
```
- Step 3
```
sudo mount /dev/(urwindowsefiblock) /mnt/windows
```
- Step 4
```
sudo cp -r /mnt/windows/EFI/Microsoft /boot/EFI
```
- Step 5 For Check EFI Microsoft is in there (above command to check if copied)
```
sudo ls /boot/EFI
```
- Step 6
```
sudo nano /boot/efi/loader/loader.conf
```
- Or
```
sudo nano /boot/loader/loader.conf
```
- Step 7 add these two lines
```
timeout 5
console-mode 0
```
- Done

---
  </details>
</details>

<details>
  <summary><strong> How to make firefox glowie? </strong></summary>

---

(requires [hnhx config](https://github.com/hnhx/user.js) or [My config](https://github.com/oniichanx/neofetch/tree/main/firefox))

---

- #### if you want firefox theme

(requires [firefox look like safari theme](https://github.com/datguypiko/Firefox-Mod-Blur))

---

  </details>
</details>

<details>
  <summary><strong> How to make Archlinux Silent boot(Unified Kernel)? </strong></summary>

---

```
nano /etc/kernel/cmdline
```
```
quiet fsck.mode=skip loglevel=3 systemd.show_status=auto rd.udev.log_level=3
```
```
sudo mkinitcpio -P
```

---

  </details>
  
</details>
<details>
  <summary><strong> How to make Archlinux Silent boot(systemd)? & this work with single gpu passthough </strong></summary>

---

```
nano /boot/loader/entries/(whateverfilename.conf)
```
```
quiet fsck.mode=skip loglevel=3 systemd.show_status=auto rd.udev.log_level=3 amd_iommu=on iommu=pt nvidia-drm.modeset=1 nvidia-drm.fbdev=1
```
```
sudo mkinitcpio -P
```

---

  </details>
<details>
  <summary><strong> How to make hyprland gaming? </strong></summary>

---
- #### Install steam
```
sudo pacman -S steam
```
---
- #### Install wine & lutris
```
sudo pacman -S --needed --noconfirm lutris wine-staging wine-mono
```
---
- #### Install lutris requires missed (NVIDIA)
```
sudo pacman -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
```
---
- #### if you want play minecraft
```
sudo pacman -S --needed --noconfirm cava vscodium-bin prismlauncher-qt5-bin
```
- #### if you using nvidia-driver 545.xxx Need to downgrade to 535.113 (Flickering fix)
- ``` yay -S downgrade ```
- ``` sudo downgrade nvidia-dkms nvidia nvidia-utils lib32-nvidia-utils ```
- #### if you using nvidia-driver 545.xxx Need to downgrade to 535.113 (another way for easy)
- ``` git clone https://github.com/Frogging-Family/nvidia-all.git ```
- ``` cd nvidia-all ```
- ``` makepkg -si ```
---
- #### if you want play game on windows (requires [StartWine](https://github.com/RusNor/StartWine-Launcher))
```
curl -sLo /dev/null -w '%{url_effective}' https://github.com/RusNor/StartWine-Launcher/releases/latest
copy output link
wget https://github.com/RusNor/StartWine-Launcher/releases/tag/StartWine_v***
chmod +x StartWine_v*
./StartWine_v37*
```
or Aur
```
yay -S --needed --noconfirm startwine
```
---
- #### if you want change wallpaper quick (requires [Waypaper](https://github.com/anufrievroman/waypaper))
```
sudo pacman -S --needed --noconfirm python-pip python-pipx swaybg
```
```
pip install waypaper
```
```
pipx install waypaper
```
Or use yay packages
```
yay -S waypaper-git
```
Add this line in your hyprland.conf
```
exec-once=waypaper --restore
```
Reboot
`waypaper` will run GUI application.

---
- #### if you want macos theme
```
yay -S mojave-gtk-theme-git apple_cursor
```
---

  </details>
</details>

<details>
  <summary><strong> You do wanna firewall? </strong></summary>

---
- #### Install Gufw & xorg-xhost
```
sudo pacman -S gufw xorg-xhost
```

- ### ([gufw issues fix](https://forum.endeavouros.com/t/gufw-problems-and-solution/10666))

`sudo nano /usr/bin/gufw`
```
#!/bin/bash
Main() {
    local whoami="$(whoami)"
    if [ "$(loginctl show-session "$(loginctl|grep $whoami|sort -n|tail -n 1 |awk '{print $1}')" -p Type)" = "Type=wayland" ]
    then
        xhost +si:localuser:root
    fi
    pkexec gufw-pkexec $whoami
}
Main "$@"
```

`sudo nano /usr/bin/gufw-pkexec`
```
#!/bin/bash
LOCATIONS=`ls -ld /usr/lib/python*/site-packages/gufw/gufw.py | awk '{print $NF}'` # from source
LOCATIONS=( "${LOCATIONS[@]}" "/usr/share/gufw/gufw/gufw.py" )                    # deb package

for ((i = 0; i < ${#LOCATIONS[@]}; i++))
do
    if [[ -e "${LOCATIONS[${i}]}" ]]; then
        python3 ${LOCATIONS[${i}]} $1
    fi
done
```

---

- ### ([gufw returns a segmentation fault in line 13 fix](https://unix.stackexchange.com/questions/396806/gufw-returns-a-segmentation-fault-in-line-13))
  
`sudo nano /usr/sbin/gufw`
```
#!/bin/bash
if [ $(loginctl show-session $(loginctl|grep $(whoami)|sort -n|tail -n 1 |awk '{print $1}') -p Type) = "Type=wayland" ]; then
    xhost +si:localuser:root
fi
c_user=$(whoami)
pkexec gufw-pkexec $c_user
```

---

`To block IPV6 By Default`
```
sudo nano /etc/default/ufw

and do this

first one IPV6=yes to IPV6=no
```

`My recommended Rules`
```
sudo ufw limit SSH
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
```
---
`if you can't you lanucher gufw but Segmentation fault (core dumped) or someting right this`

Type the following command in a terminal:

```
echo $XDG_SESSION_TYPE
```
If it returns Wayland, type:

```
xhost si:localuser:root
```

it line for Revoke Access for root

```
xhost -si:localuser:root
```

you can Verify Default Settings by this command

```
xhost
```
---

If that doesn't work, try this line. This line doesn't need to be changed: `/usr/bin/gufw-pkexec`
Let it remain as default.

`sudo nano /usr/bin/gufw`

```
#!/bin/bash

Main() {
    local whoami="$(whoami)"
    local session_id=$(loginctl list-sessions "$whoami" | sort -n | tail -n 1 | awk '{print $1}')
    local session_type=$(loginctl show-session "$session_id" -p Type --value)

    if [ "$session_type" = "wayland" ]; then
        echo "Wayland session detected. Using alternative approach for permissions."
        # Modify this section based on specific Wayland permissions mechanisms
        # Example: Consider using PolicyKit or custom Wayland-specific rules
        pkexec gufw-pkexec $whoami
    else
        # For non-Wayland sessions (e.g., X11), use xhost to allow root access
        xhost +si:localuser:root

        # Run gufw with pkexec to launch with elevated privileges
        pkexec gufw-pkexec $whoami
    fi
}

Main "$@"

```

This line only working with terminal or kitty 

---

- ### ([gufw not launching - add an "s" to the policy](https://unix.stackexchange.com/questions/396806/gufw-returns-a-segmentation-fault-in-line-13))
  
`sudo nano /usr/share/polkit-1/actions/com.ubuntu.pkexec.gufw.policy`

change this line

```
<annotate key="org.freedesktop.policykit.exec.path">/usr/bin/gufw-pkexec</annotate>
```

to this one

```
<annotate key="org.freedesktop.policykit.exec.path">/usr/sbin/gufw-pkexec</annotate>
```

---

</details>
</details>

<details>
  <summary><strong> You do wanna my wallpaper set? </strong></summary>
  
- ### ([Wallpaper Set](https://github.com/oniichanx/neofetch/tree/main/wallpaper))
</details>
</details>

<details>
  <summary><strong> How to Single GPU Passthrough? </strong></summary>
  
- #### ([Single GPU Passthrough Link](https://oniichanx.github.io/Windows-10-11-Single-GPU-Passthrough/))
</details>
</details>
