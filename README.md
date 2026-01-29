<div align="center">

# ✨ RAINZ'S Arch Hyprland Rice

_A meticulously crafted Arch Linux desktop experience_

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-00D9FF?style=for-the-badge&logo=wayland&logoColor=white)](https://hyprland.org/)
[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Fish Shell](https://img.shields.io/badge/Fish_Shell-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://fishshell.com/)

---

_Elevate your Linux workflow with this carefully curated collection of dotfiles_

</div>
<!-- <div align="center"> -->
<!---->
<!-- ### Desktop Showcase -->
<!---->
<!-- <table> -->
<!--   <tr> -->
<!--     <td width="50%"> -->
<!--       <img src="https://github.com/user-attachments/assets/7a85eb93-d3df-493f-a341-e0f13547f6a6" alt="Desktop Overview" style="border-radius: 8px;"/> -->
<!--       <p><em>Clean Desktop with Waybar and Rofi</em></p> -->
<!--     </td> -->
<!--     <td width="50%"> -->
<!--       <img src="https://github.com/user-attachments/assets/68f81533-c7a9-4d90-951c-9a4c0ce9931c" alt="Terminal Setup" style="border-radius: 8px;"/> -->
<!--       <p><em>Terminal & Development Environment</em></p> -->
<!--     </td> -->
<!--   </tr> -->
<!--   <tr> -->
<!--     <td width="50%"> -->
<!--       <img src="https://github.com/user-attachments/assets/d5e6620b-7521-467b-a809-d53609db8cf0" alt="Application Launcher" style="border-radius: 8px;"/> -->
<!--       <p><em>Spotify with Cava</em></p> -->
<!--     </td> -->
<!--     <td width="50%"> -->
<!--       <img src="https://github.com/user-attachments/assets/9b87382c-5a32-4fbe-99ce-53f1a1bd9e9d" alt="Browser Setup" style="border-radius: 8px;"/> -->
<!--       <p><em>SDDM Theme</em></p> -->
<!--     </td> -->
<!--   </tr> -->
<!-- </table> -->
<!---->
<!-- </div> -->

## <!---->

## ⚡ Tech Stack

<div align="center">

|      Component       |         Choice         |              Why               |
| :------------------: | :--------------------: | :----------------------------: |
|      🐧 **OS**       |      `Arch Linux`      |   Rolling release perfection   |
|      🪟 **WM**       |       `Hyprland`       |   Smooth Wayland animations    |
|    🌐 **Browser**    |     `Zen Browser`      | Privacy-focused & customizable |
|   🖥️ **Terminal**    |        `Kitty`         |  GPU-accelerated performance   |
|     🐚 **Shell**     |  `Fish + Oh My Posh`   |   Beautiful & user-friendly    |
|    ✏️ **Editor**     |        `Neovim`        |    Extensible text editing     |
|   🚀 **Launcher**    |         `Rofi`         |   Fast application switching   |
|      📊 **Bar**      |        `Waybar`        |   Highly customizable status   |
| 🔔 **Notifications** |        `SwayNC`        |   Clean notification system    |
|   🖼️ **Wallpaper**   | `Hyprpaper + Waypaper` |  Dynamic wallpaper management  |

</div>

---

## 🚀 Quick Start

### Prerequisites

```bash
# Ensure you have these essentials
- Arch Linux (fresh install recommended)
- git, yay, sudo privileges
- Proper GPU drivers installed
```

### One-Command Setup

```bash
git clone https://github.com/R7rainz/dotfiles.git ~/dotfiles && cd ~/dotfiles
```

## Neovim Setup ( recommended to setup in a different repo for better updates and management )

Want to try my Neovim configuration?  
You can find it here: **https://github.com/R7rainz/neovim-conf** 

If you like it, consider leaving a ⭐ — it really helps!

Clone it directly into your Neovim config directory:

```bash
git clone https://github.com/R7rainz/neovim-conf ~/.config/nvim
```

---

## 📦 Installation Steps

<details>
<summary><b>🏗️ Step 1: Hyprland Installation</b></summary>

### System Update & Dependencies

```bash
sudo pacman -Syu
sudo pacman -S base-devel cmake meson ninja gcc pkgconf libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus hyprlang hyprcursor hyprwayland-scanner
```

### GPU Drivers

**NVIDIA:**

```bash
sudo pacman -S nvidia nvidia-utils nvidia-settings
# Add to /etc/mkinitcpio.conf: MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
sudo mkinitcpio -P
# Add to GRUB: nvidia_drm.modeset=1
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

**AMD:**

```bash
sudo pacman -S mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon
```

**Intel:**

```bash
sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel
```

### Install Hyprland

```bash
sudo pacman -S hyprland
# Or for latest features:
yay -S hyprland-git
yay -S xdg-desktop-portal-hyprland-git
```

### Configure XDG Desktop Portal

```bash
# Install required portal packages
sudo pacman -S xdg-desktop-portal-wlr xdg-desktop-portal-gtk

# Create portal configuration
mkdir -p ~/.config/xdg-desktop-portal
cat > ~/.config/xdg-desktop-portal/portals.conf << EOF
[preferred]
default=hyprland;gtk
org.freedesktop.impl.portal.Screenshot=hyprland
org.freedesktop.impl.portal.ScreenCast=hyprland
org.freedesktop.impl.portal.FileChooser=gtk
EOF
```

</details>

<details>
<summary><b>📦 Step 2: Core Packages</b></summary>

```bash
# System essentials
sudo pacman -S git stow brightnessctl pacman-contrib pipewire pipewire-pulse wireplumber bluez-utils pulseaudio pavucontrol blueman wayland wayland-protocols wlroots

# Applications
sudo pacman -S kitty fish neovim rofi hyprpaper thunar gvfs gvfs-mtp npm
yay -S waybar swaync waypaper zen-browser-bin pnpm-bin

# Fonts & Tools
sudo pacman -S ttf-jetbrains-mono-nerd ttf-liberation ttf-dejavu
yay -S ttf-inconsolata-lgc-nerd ttf-hurmit-nerd bat fastfetch

# Oh My Posh
curl -s https://ohmyposh.dev/install.sh | bash -s
```

</details>

<details>
<summary><b>🌐 Step 3: Zen Browser Setup</b></summary>

### Nebula Theme Installation

```bash
git clone https://github.com/JustAdumbPrsn/Zen-Nebula.git ~/zen-nebula
```

### Apply Custom CSS

1. Open Zen Browser → `about:config`
2. Set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`
3. Go to `about:support` → Open Profile Folder
4. Create `chrome` folder
5. Copy CSS files:

```bash
cp ~/zen-nebula/userChrome.css ~/.zen/[your-profile]/chrome/
cp ~/zen-nebula/userContent.css ~/.zen/[your-profile]/chrome/
```

### Extensions & Settings

- Install **uBlock Origin**
- Enable **Compact Sidebar Mode**
- Configure privacy settings

</details>

<details>
<summary><b>🎭 Step 4: SDDM Theme Setup</b></summary>

```bash
# Install SDDM theme
sudo chmod +x ~/dotfiles/install-sddm-theme.sh
sudo ~/dotfiles/install-sddm-theme.sh

# The theme will be installed to: /usr/share/sddm/themes/silent
```

</details>

<details>
<summary><b>⚙️ Step 5: System Configuration</b></summary>

### Services

```bash
# Audio
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber

# Bluetooth
sudo systemctl enable bluetooth && sudo systemctl start bluetooth

# Display Manager
sudo systemctl enable sddm
```

### Configure Display Manager

```bash
# Configure SDDM to use Wayland session
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/10-wayland.conf << EOF
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell

[Wayland]
CompositorCommand=Hyprland
EOF
```

</details>

<details>
<summary><b>🔗 Step 6: Apply Dotfiles</b></summary>

```bash
cd ~/dotfiles

# Individual stowing (recommended)
stow batfetch
stow fastfetch
stow fish
stow oh-my-posh
stow kitty
stow neovim
stow rofi
stow swaync
stow waybar
stow hyprpaper
stow waypaper
stow hyprland

# Or stow everything at once (be careful of conflicts)
# stow */
```

### Configure Shell

```bash
# Set Fish as default shell
echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish

# Verify Oh My Posh theme
ls -la ~/.config/oh-my-posh/themes/custom.omp.json
```

### Font Configuration

```bash
# Refresh font cache
fc-cache -fv

# Verify fonts are installed
fc-list | grep -i "jetbrains\\|hurmit\\|inconsolata"
```

</details>

<details>
<summary><b>✅ Step 7: Final Configuration</b></summary>

### Reload Fish Configuration

```bash
fish
source ~/.config/fish/config.fish
```

### Test Applications

```bash
# Test fetch tools
batfetch
fastfetch

# Test terminal
kitty &

# Test editor
nvim

# Test application launcher
rofi -show drun

# Test browser
zen-browser &
```

### Launch Hyprland

```bash
# If using a display manager, select Hyprland from the session menu
# Or start Hyprland manually from TTY:
Hyprland
```

</details>

---

## 🔄 Updating Dotfiles

To update your dotfiles after making changes:

```bash
cd ~/dotfiles

# Restow modified packages
stow -R package-name

# Or restow all packages
stow -R */
```

---

## 🗂️ Directory Structure

```
~/dotfiles/
├── .config/
│   ├── hypr/
│   │   ├── hyprland.conf
│   │   ├── hyprpaper.conf
│   │   └── scripts/
│   ├── batfetch/
│   ├── fastfetch/
│   ├── fish/
│   ├── oh-my-posh/
│   │   └── themes/
│   │       └── custom.omp.json
│   ├── kitty/
│   ├── neovim/
│   ├── rofi/
│   ├── swaync/
│   ├── waybar/
│   ├── hyprpaper/
│   └── waypaper/
├── Wallpapers/
├── system/
│   └── sddm/
│       └── themes/
│           └── silent/
└── install-sddm-theme.sh
```

---

## 🎨 Customization Options

### 🪟 **Hyprland Configuration**

The Hyprland setup includes:

- **🎨 Custom animations** - Smooth window transitions and effects
- **⌨️ Keybindings** - Optimized keyboard shortcuts for productivity
- **🖥️ Multi-monitor support** - Seamless workspace management across displays
- **🎯 Window rules** - Automatic window positioning and behavior
- **🔧 Performance optimizations** - Tuned for smooth operation

#### Key Features

- **Tiling and floating modes** with easy switching
- **Workspace management** with smooth animations
- **Custom gaps and borders** for aesthetic appeal
- **Screen sharing support** via xdg-desktop-portal-hyprland

### 🌐 **Zen Browser**

The browser setup includes:

- **🌌 Nebula Theme** - Beautiful dark theme with cosmic aesthetics
- **🛡️ uBlock Origin** - Advanced ad and tracker blocking
- **📱 Compact Sidebar** - Space-efficient navigation
- **🎨 Custom CSS** - Personalized interface styling

#### Browser Extensions

- **uBlock Origin**: Essential privacy and ad-blocking extension
  - Enable additional filter lists for enhanced protection
  - Configure custom filters as needed

#### Nebula Theme Features

- Dark cosmic color scheme
- Smooth animations and transitions
- Compact interface design
- Enhanced readability

### 🔤 **Fonts**

The setup uses these carefully selected fonts:

- **🚀 JetBrains Mono Nerd Font** - Main monospace font with excellent readability
- **⚡ Hurmit Nerd Font** - Alternative monospace with unique character
- **📝 InconsolataLGC Nerd Font** - Additional monospace option for variety

### 🎭 **Oh My Posh Theme**

The custom theme is located at `~/.config/oh-my-posh/themes/custom.omp.json`.
Modify this file to customize your shell prompt appearance and behavior.

### 📊 **Waybar Configuration**

Waybar modules include:

- 📶 **Bluetooth** (with custom scripts)
- 🔊 **Audio control** (PulseAudio/Pipewire)
- 🔆 **Brightness control**
- 💻 **System information**
- 📦 **Package update notifications**
- 🪟 **Hyprland workspaces** integration

---

## 🛠️ Troubleshooting

### ⚠️ **Common Issues**

1. **🔗 Stow conflicts**: Use `stow --adopt package-name` to resolve conflicts
2. **🔤 Font not loading**: Run `fc-cache -fv` and restart applications
3. **🔊 Audio issues**: Check PipeWire services with `systemctl --user status pipewire`
4. **📶 Bluetooth not working**: Ensure bluetoothd service is running
5. **🌐 Zen Browser CSS not applying**: Ensure `toolkit.legacyUserProfileCustomizations.stylesheets` is set to `true`
6. **🪟 Hyprland not starting**: Check GPU drivers and Wayland support
7. **🖥️ Screen sharing not working**: Ensure xdg-desktop-portal-hyprland is installed and configured

### 🔍 **Logs and Debugging**

```bash
# Check Hyprland logs
journalctl --user -u hyprland

# Check Waybar logs
journalctl --user -u waybar

# Check PipeWire status
systemctl --user status pipewire pipewire-pulse wireplumber

# Test audio
pactl info

# Check Zen Browser profile location
zen-browser --ProfileManager

# Debug Hyprland configuration
hyprctl version
hyprctl monitors
hyprctl workspaces
```

### 🪟 **Hyprland Troubleshooting**

```bash
# Check if Hyprland is running
pgrep Hyprland

# Restart Hyprland (from within Hyprland)
hyprctl dispatch exit

# Check GPU acceleration
glxinfo | grep "direct rendering"

# For NVIDIA users - check if drivers are loaded
lsmod | grep nvidia

# Test Wayland support
echo $XDG_SESSION_TYPE
```

### 🌐 **Browser Troubleshooting**

```bash
# Reset Zen Browser profile if needed
rm -rf ~/.zen/[profile-name]/chrome/

# Reapply Nebula theme
cp ~/zen-nebula/*.css ~/.zen/[profile-name]/chrome/

# Check if custom CSS is enabled
# Navigate to about:config and verify toolkit.legacyUserProfileCustomizations.stylesheets = true
```

---

## 📝 Important Notes

> **⚠️ Backup Warning**: Always backup your existing configurations before stowing

- 🔄 Some applications may require a logout/login or restart to fully apply themes
- 👑 The SDDM theme requires root privileges to install
- 📶 Custom bluetooth scripts are included in the bluetooth directory
- 🎨 Themes and colors can be customized in individual config files
- 🌐 Browser CSS changes require browser restart to take effect
- 🛡️ uBlock Origin settings can be exported/imported for easy setup across devices
- 🪟 **NVIDIA users**: May need additional configuration for optimal Hyprland performance
- 🖥️ **Multi-monitor setups**: Configure displays in `~/.config/hypr/hyprland.conf`
- ⚡ **Performance**: Hyprland performs best with modern GPUs and drivers

---

## 💝 Support

<div align="center">

**Enjoying this rice? Show some love!**

[![GitHub Stars](https://img.shields.io/github/stars/R7rainz/dotfiles?style=for-the-badge&logo=github&color=yellow)](https://github.com/R7rainz/dotfiles/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/R7rainz/dotfiles?style=for-the-badge&logo=github&color=blue)](https://github.com/R7rainz/dotfiles/network)

[![Issues](https://img.shields.io/badge/Issues-Welcome-brightgreen?style=for-the-badge&logo=github)](https://github.com/R7rainz/dotfiles/issues)
[![Pull Requests](https://img.shields.io/badge/PRs-Welcome-blue?style=for-the-badge&logo=github)](https://github.com/R7rainz/dotfiles/pulls)

</div>

---

## 🤝 Contributing

<div align="center">

**Found a bug? Have an improvement?**

Feel free to fork this repository and submit pull requests for improvements or additional configurations.

</div>

---

## 🙏 Credits

- **[Arch Linux](https://archlinux.org/)** - The best rolling release distribution
- **[Hyprland](https://hyprland.org/)** - Dynamic tiling Wayland compositor
- **[Zen Browser](https://zen-browser.app/)** - Privacy-focused Firefox-based browser
- **[Nebula Theme](https://github.com/JustAdumbPrsn/Zen-Nebula)** - Beautiful cosmic theme for Zen Browser
- **[Oh My Posh](https://ohmyposh.dev/)** - Cross-platform prompt theme engine
- **[Waybar](https://github.com/Alexays/Waybar)** - Highly customizable Wayland bar

---

<img src="https://github.com/user-attachments/assets/03ef993e-2fad-4668-a313-2b2a31d6b66e" alt="RAINZ" width="50" style="border-radius: 50%;"/>

**Crafted by RAINZ** • _Making Linux beautiful, one rice at a time_

⭐ **Star this repo if it helped you!**

**Made with ❤️ for the Arch Linux and Hyprland community**

</div>
