<div align="center">

# 🚀 Modern Arch Linux Hyprland Dotfiles

*A comprehensive setup for a sleek Arch Linux desktop environment with Hyprland*

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-00D9FF?style=for-the-badge&logo=wayland&logoColor=white)](https://hyprland.org/)
[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Fish Shell](https://img.shields.io/badge/Fish_Shell-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://fishshell.com/)

---

*Transform your Arch Linux experience with this carefully curated collection of dotfiles featuring Hyprland's modern Wayland compositor, beautiful themes, and productivity-focused tools.*

</div>

## 🖥️ System Showcase

<div align="center">

| Component | Technology | Description |
|-----------|------------|-------------|
| 🐧 **Distribution** | `Arch Linux` | Rolling release Linux distribution |
| 🪟 **Window Manager** | `Hyprland` | Modern Wayland compositor with animations |
| 🌐 **Browser** | `Zen Browser` | Privacy-focused Firefox-based browser |
| 🖥️ **Terminal** | `Kitty` | GPU-accelerated terminal emulator |
| 🐚 **Shell** | `Fish + Oh My Posh` | User-friendly shell with beautiful prompts |
| ✏️ **Editor** | `Neovim` | Extensible text editor |
| 🚀 **App Launcher** | `Rofi` | Application launcher and window switcher |
| 📊 **Status Bar** | `Waybar` | Highly customizable status bar |
| 🔔 **Notifications** | `SwayNC` | Notification daemon for Wayland |
| 🖼️ **Wallpaper** | `Hyprpaper + Waypaper` | Wallpaper management |
| 🔐 **Display Manager** | `SDDM` | Simple Desktop Display Manager |
| 🔊 **Audio** | `PulseAudio + Pipewire` | Modern audio stack |

</div>

---

## 📋 Prerequisites

> **Important**: Ensure you have the following before proceeding

- 🐧 **Arch Linux** (fresh installation recommended)
- 📦 **git** installed
- 🔧 **yay** AUR helper installed  
- 👑 **sudo** privileges
- 🖥️ **GPU drivers** properly installed (NVIDIA users need additional setup)

---

## 🛠️ Installation Guide

### 📥 **Step 1: Clone the Repository**

```bash
git clone https://github.com/R7rainz/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 🏗️ **Step 2: Install Hyprland on Arch Linux**

#### Essential Dependencies

```bash
# Update system first
sudo pacman -Syu

# Install essential dependencies for Hyprland
sudo pacman -S base-devel cmake meson ninja gcc pkgconf libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus hyprlang hyprcursor hyprwayland-scanner
```

#### Graphics Drivers Setup

**For NVIDIA Users:**
```bash
# Install NVIDIA drivers (choose appropriate version)
sudo pacman -S nvidia nvidia-utils nvidia-settings

# For older cards, use nvidia-470xx-dkms instead
# yay -S nvidia-470xx-dkms nvidia-470xx-utils

# Add NVIDIA modules to mkinitcpio
sudo nano /etc/mkinitcpio.conf
# Add: MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)

# Regenerate initramfs
sudo mkinitcpio -P

# Enable DRM kernel mode setting
sudo nano /etc/default/grub
# Add to GRUB_CMDLINE_LINUX_DEFAULT: nvidia_drm.modeset=1

# Update GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

**For AMD Users:**
```bash
# Install AMD drivers
sudo pacman -S mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon
```

**For Intel Users:**
```bash
# Install Intel drivers
sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel
```

#### Install Hyprland

```bash
# Install Hyprland from official repositories
sudo pacman -S hyprland

# Or install the latest development version from AUR (recommended for latest features)
yay -S hyprland-git

# Install additional Hyprland tools
yay -S xdg-desktop-portal-hyprland-git
```

#### Configure XDG Desktop Portal

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

### 📦 **Step 3: Install Required Packages**

#### 🔧 Core System Packages

```bash
# Core utilities and dependencies
sudo pacman -S git stow brightnessctl pacman-contrib pipewire pipewire-pulse wireplumber bluez-utils

# Audio control
sudo pacman -S pulseaudio pavucontrol

# Bluetooth
sudo pacman -S blueman

# Wayland essentials
sudo pacman -S wayland wayland-protocols wlroots
```

#### 🚀 Main Applications

```bash
# Terminal and shell
sudo pacman -S kitty fish

# Editor and system tools
sudo pacman -S neovim rofi hyprpaper

# Wayland compositor tools
yay -S waybar swaync waypaper

# Browser
yay -S zen-browser-bin

# File manager and utilities
sudo pacman -S thunar gvfs gvfs-mtp
```

#### 💻 Development Tools

```bash
# Package managers and helpers
sudo pacman -S npm
yay -S pnpm-bin

# Make sure yay is installed
# If not: git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

#### 🔤 Fonts

```bash
# Install required fonts
sudo pacman -S ttf-jetbrains-mono-nerd ttf-liberation ttf-dejavu
yay -S ttf-inconsolata-lgc-nerd ttf-hurmit-nerd
```

#### 📊 Fetch Tools

```bash
# System information tools
yay -S bat fastfetch
```

#### 🎨 Oh My Posh Theme Engine

```bash
# Install Oh My Posh
curl -s https://ohmyposh.dev/install.sh | bash -s
```

### 🌐 **Step 4: Configure Zen Browser**

#### Install Zen Browser Theme (Nebula)

```bash
# Clone the Nebula theme repository
git clone https://github.com/JustAdumbPrsn/Zen-Nebula.git ~/zen-nebula
cd ~/zen-nebula
```

#### Apply Custom CSS

1. **Open Zen Browser** and navigate to `about:config`
2. **Search for** `toolkit.legacyUserProfileCustomizations.stylesheets`
3. **Set the value to** `true`
4. **Navigate to** `about:support`
5. **Click** "Open Folder" next to "Profile Folder"
6. **Create a** `chrome` **folder** if it doesn't exist
7. **Copy the CSS files** from the Nebula repository:

```bash
# Copy the userChrome.css to your profile
cp ~/zen-nebula/userChrome.css ~/.zen/[your-profile]/chrome/
cp ~/zen-nebula/userContent.css ~/.zen/[your-profile]/chrome/
```

#### Browser Configuration

1. **Enable Compact Mode**:
   - Go to `Settings` → `Zen` → `Sidebar`
   - Enable "Compact Mode"

2. **Install Extensions**:
   - **uBlock Origin**: Install from Firefox Add-ons store
   - Configure uBlock Origin with your preferred filter lists

3. **Additional Settings**:
   - Enable sidebar in compact mode
   - Configure privacy settings as needed
   - Set up sync if desired

### 🎭 **Step 5: Setup SDDM Theme**

```bash
# Install SDDM theme
sudo chmod +x ~/dotfiles/install-sddm-theme.sh
sudo ~/dotfiles/install-sddm-theme.sh

# The theme will be installed to: /usr/share/sddm/themes/silent
```

### ⚙️ **Step 6: Configure Services**

#### 📶 Enable Bluetooth

```bash
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
```

#### 🔊 Enable Audio Services

```bash
# Enable PipeWire services (user-level)
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber
```

#### 🖥️ Configure Display Manager

```bash
# Enable SDDM
sudo systemctl enable sddm

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

### 🔗 **Step 7: Apply Dotfiles with Stow**

Navigate to your dotfiles directory and stow the configurations:

```bash
cd ~/dotfiles

# Stow individual packages (recommended for first-time setup)
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
stow hyprland  # This will stow Hyprland configuration

# Or stow everything at once (be careful of conflicts)
# stow */
```

### 🐚 **Step 8: Configure Shell**

#### Set Fish as Default Shell

```bash
# Add fish to valid shells
echo /usr/bin/fish | sudo tee -a /etc/shells

# Change default shell
chsh -s /usr/bin/fish
```

#### Install Oh My Posh Theme

```bash
# The custom theme should already be linked via stow
# Verify the theme file exists
ls -la ~/.config/oh-my-posh/themes/custom.omp.json
```

### 🔤 **Step 9: Font Configuration**

Ensure the fonts are properly recognized:

```bash
# Refresh font cache
fc-cache -fv

# Verify fonts are installed
fc-list | grep -i "jetbrains\\|hurmit\\|inconsolata"
```

### ✅ **Step 10: Final Configuration**

#### Reload Fish Configuration

```bash
fish
source ~/.config/fish/config.fish
```

#### Test Applications

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

#### Launch Hyprland

```bash
# If using a display manager, select Hyprland from the session menu
# Or start Hyprland manually from TTY:
Hyprland
```

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

## 🤝 Contributing

<div align="center">

**Found a bug? Have an improvement?**

Feel free to fork this repository and submit pull requests for improvements or additional configurations.

[![GitHub Issues](https://img.shields.io/badge/Issues-Welcome-brightgreen?style=for-the-badge&logo=github)](https://github.com/R7rainz/dotfiles/issues)
[![Pull Requests](https://img.shields.io/badge/PRs-Welcome-blue?style=for-the-badge&logo=github)](https://github.com/R7rainz/dotfiles/pulls)

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

*⭐ If you found this helpful, consider giving it a star!*

**Made with ❤️ for the Arch Linux and Hyprland community**

</div>
