<div align="center">

# ✨ RAINZ'S Arch Hyprland Rice

_A meticulously crafted Arch Linux desktop experience_

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-00D9FF?style=for-the-badge&logo=wayland&logoColor=white)](https://hyprland.org/)
[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Fish Shell](https://img.shields.io/badge/Fish_Shell-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://fishshell.com/)
[![Noctalia Shell](https://img.shields.io/badge/Noctalia_Shell-A8AEFF?style=for-the-badge&logo=wayland&logoColor=white)](https://docs.noctalia.dev/)

---

_Elevate your Linux workflow with this carefully curated collection of dotfiles_

<p align="center"> <img src="https://github.com/user-attachments/assets/b4ab952f-be97-499d-a486-d246c987d4e2" width="90%" /> </p> <p align="center">
<p align="center"> <img src="https://github.com/user-attachments/assets/f2643df2-ad5f-45e7-bf4d-82cae17e38ee" width="70%" /> </p> <p align="center"> <em>Neovim setup with bufferline, telescope, and modern UI tweaks</em> </p>


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

|      Component       |           Choice            |              Why               |
| :------------------: | :-------------------------: | :----------------------------: |
|      🐧 **OS**       |        `Arch Linux`         |   Rolling release perfection   |
|      🪟 **WM**       |         `Hyprland`          |   Smooth Wayland animations    |
|   🌙 **Desktop Shell**   |     `Noctalia Shell`        |   Sleek, minimal Wayland shell |
|    🌐 **Browser**    |        `Zen Browser`        | Privacy-focused & customizable |
|   🖥️ **Terminal**    |      `Kitty + Wezterm`      |  GPU-accelerated performance   |
|     🐚 **Shell**     | `Fish + Starship` |   Beautiful & user-friendly    |
|    ✏️ **Editor**     |          `Neovim`           |    Extensible text editing     |
|   🚀 **Launcher**    |      `Rofi + Vicinae`       |   Fast application switching   |
|      📊 **Bar**      |      `Noctalia Bar`         |   Built into Noctalia Shell    |
| 🔔 **Notifications** |      `Noctalia Notifications`|   Integrated notification system|
|   🖼️ **Wallpaper**   |   `Hyprpaper + Waypaper`    |  Dynamic wallpaper management  |
| 📁 **File Manager**  |           `Yazi`            |   Terminal-based file manager  |
| 📄 **PDF Viewer**    |          `Zathura`          |    Vim-like document viewer    |
|   🖥️ **Multiplexer** |           `Tmux`            |   Terminal session management  |

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
<summary><b>🌙 Step 1.5: Noctalia Shell Installation</b></summary>

### What is Noctalia Shell?

[Noctalia Shell](https://github.com/noctalia-dev/noctalia-shell) is a sleek and minimal desktop shell thoughtfully crafted for Wayland. Built on [Quickshell](https://quickshell.outfoxxed.me/), it provides:

- Beautiful status bar with integrated modules
- Notification center
- Application launcher
- Control center with quick settings
- Lock screen
- Plugin support for extensibility

### Installation (Arch Linux)

**Using AUR (Recommended):**

```bash
# Install stable version
paru -S noctalia-shell

# Or install development version for latest features
paru -S noctalia-shell-git
```

### Dependencies

Noctalia Shell will automatically install its dependencies, but here's what it uses:

**Required:**
- `quickshell` - Core shell framework
- `brightnessctl` - Screen brightness control
- `imagemagick` - Image processing for wallpapers
- `python` - Required for template processing
- `git` - Update checking and plugin system

**Optional (Recommended):**
```bash
paru -S cliphist cava wlsunset power-profiles-daemon ddcutil
```

- `cliphist` - Clipboard history support
- `cava` - Audio visualizer component
- `wlsunset` - Night light functionality
- `power-profiles-daemon` - Power profile management
- `ddcutil` - External display brightness control

### Running Noctalia Shell

Add this line to your Hyprland config (`~/.config/hypr/hyprland.conf`):

```bash
exec-once = qs -c noctalia-shell
```

### Hyprland Settings for Noctalia

Add these settings for optimal integration with Noctalia Shell:

```bash
# Enable blur for Noctalia panels
layerrule {
  name = noctalia
  match:namespace = noctalia-background-.*$
  ignore_alpha = 0.5
  blur = true
  blur_popups = true
}
```

### Noctalia IPC Commands

Noctalia uses IPC for various functions. Example keybind for lock screen:

```bash
# Lock screen
bind = SUPER, L, exec, qs -c noctalia-shell ipc call lockScreen lock
```

### Configuration

Noctalia configuration is stored in:
- Config: `~/.config/noctalia/`
- Cache: `~/.cache/noctalia/`

### Resources

- [Noctalia Documentation](https://docs.noctalia.dev)
- [GitHub Repository](https://github.com/noctalia-dev/noctalia-shell)
- [Discord Community](https://discord.noctalia.dev)

</details>

<details>
<summary><b>📦 Step 2: Core Packages</b></summary>

```bash
# System essentials
sudo pacman -S git stow brightnessctl pacman-contrib pipewire pipewire-pulse wireplumber bluez-utils pulseaudio pavucontrol blueman wayland wayland-protocols wlroots

# Applications
sudo pacman -S kitty wezterm fish neovim rofi hyprpaper thunar gvfs gvfs-mtp npm yazi zathura zathura-pdf-mupdf tmux
yay -S waypaper zen-browser-bin pnpm-bin avizo vicinae

# Noctalia Shell (replaces waybar, swaync, mako)
yay -S noctalia-shell

# Fonts & Tools
sudo pacman -S ttf-jetbrains-mono-nerd ttf-liberation ttf-dejavu starship
yay -S ttf-inconsolata-lgc-nerd ttf-hurmit-nerd bat fastfetch kotofetch
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
stow avizo
stow batfetch
stow fastfetch
stow fish
stow kitty
stow wezterm
stow neovim
stow rofi
stow hyprland
stow yazi
stow zathura
stow starship

# Note: Noctalia Shell manages its own config in ~/.config/noctalia/
# You don't need to stow waybar, swaync, or mako if using Noctalia Shell

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
│   ├── avizo/              # Volume/brightness OSD
│   ├── batfetch/           # Fetch utility
│   ├── fastfetch/          # System info fetch
│   ├── fish/               # Fish shell config
│   ├── hypr/               # Hyprland configs
│   │   ├── hyprland.conf   # Main config (includes Noctalia autostart)
│   │   ├── hypridle.conf
│   │   ├── hyprlock.conf
│   │   ├── window_rules.conf
│   │   └── scripts/
│   ├── kitty/              # Kitty terminal (Noctalia theme)
│   ├── kotofetch/          # Fetch utility
│   ├── nvim/               # Neovim config
│   ├── oh-my-posh/         # Shell prompt theme (alternative)
│   │   └── themes/
│   │       └── custom.omp.json
│   ├── rofi/               # Application launcher
│   ├── scripts/            # Utility scripts
│   ├── starship.toml       # Starship prompt config
│   ├── wezterm/            # Wezterm terminal
│   │   ├── wezterm.lua     # Main config with Noctalia colors
│   │   └── colors/
│   │       └── Noctalia.toml  # Noctalia color scheme
│   ├── yazi/               # File manager (Noctalia flavor)
│   └── zathura/            # PDF viewer
├── system/
│   └── sddm/
│       └── themes/
│           └── silent/
├── bluetooth-auto-switch.sh
├── install-bluetooth-auto-switch.sh
└── install-sdddm-theme.sh
```

---

## 🎨 Customization Options

### 🌙 **Noctalia Shell**

This rice uses [Noctalia Shell](https://github.com/noctalia-dev/noctalia-shell) as the primary desktop shell, replacing traditional status bars and notification daemons.

#### Features
- **Status Bar** - Clean, minimal bar with workspace indicators, system tray, and clock
- **Notification Center** - Integrated notification system with history
- **Control Center** - Quick settings panel for Wi-Fi, Bluetooth, brightness, volume
- **Application Launcher** - Built-in launcher (or use Rofi/Vicinae)
- **Lock Screen** - Integrated lock screen via IPC

#### Key Components
| Component | Noctalia Equivalent |
|-----------|---------------------|
| Waybar | Noctalia Bar |
| SwayNC/Mako | Noctalia Notifications |
| wlogout | Noctalia Power Menu |

#### Configuration
Noctalia Shell stores its configuration at `~/.config/noctalia/`. Access settings through the shell's built-in settings panel.

#### Useful IPC Commands
```bash
# Lock screen
qs -c noctalia-shell ipc call lockScreen lock

# Toggle control center
qs -c noctalia-shell ipc call controlCenter toggle

# Toggle launcher
qs -c noctalia-shell ipc call launcher toggle
```

#### Noctalia Color Theme
The Noctalia color palette is used across multiple applications:

| Color | Hex | Usage |
|-------|-----|-------|
| Background | `#141316` | Dark charcoal base |
| Foreground | `#e6e1e6` | Light gray text |
| Accent Pink | `#eeb8cb` | Highlights |
| Accent Purple | `#cbbeff` | Secondary accent |
| Accent Red | `#ffb4ab` | Alerts/errors |

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

### 🎭 **Oh My Posh / Starship Theme**

Two shell prompt options are available:

- **Oh My Posh**: Custom theme at `~/.config/oh-my-posh/themes/custom.omp.json`
- **Starship**: Configuration at `~/.config/starship.toml`

Modify these files to customize your shell prompt appearance and behavior.

### 📊 **Status Bar (Noctalia)**

Noctalia Shell provides an integrated status bar with:

- 📶 **Bluetooth & Network** indicators
- 🔊 **Audio control** (PipeWire integration)
- 🔆 **Brightness control** 
- 💻 **System information**
- 🪟 **Hyprland workspaces** integration
- 🔔 **Notification indicator**

> **Note**: Waybar config files are included in this repo for reference, but Noctalia Shell's bar is the primary status bar.

### 🖥️ **Terminal Emulators**

Two terminal options are included, both with the **Noctalia color scheme**:

- **Kitty**: Fast, GPU-accelerated terminal with config at `~/.config/kitty/`
  - Uses Noctalia theme via `current-theme.conf`
- **Wezterm**: Feature-rich terminal with Lua config at `~/.config/wezterm/`
  - Custom Noctalia color scheme at `~/.config/wezterm/colors/Noctalia.toml`
  - Full color palette defined inline in `wezterm.lua`

### 📁 **Yazi File Manager**

Terminal-based file manager with:

- **Noctalia theme/flavor** for both dark and light modes
- Vim-style keybindings
- Image previews support
- Configuration at `~/.config/yazi/theme.toml`

### 📄 **Zathura PDF Viewer**

Minimalist PDF viewer with vim keybindings configured at `~/.config/zathura/`

### 🖥️ **Tmux Configuration**

Terminal multiplexer setup at `~/.config/tmux/tmux.conf`

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
8. **🌙 Noctalia Shell not starting**: Check if quickshell is installed with `pacman -Q quickshell`
9. **🌙 Noctalia bar not showing**: Ensure `exec-once = qs -c noctalia-shell` is in your hyprland.conf

### 🌙 **Noctalia Shell Troubleshooting**

```bash
# Check if Noctalia/Quickshell is running
pgrep -f "qs.*noctalia"

# Restart Noctalia Shell
killall qs && qs -c noctalia-shell &

# Check Noctalia logs
journalctl --user -f | grep -i noctalia

# Verify quickshell installation
pacman -Qi quickshell
pacman -Qi noctalia-shell

# Test IPC commands
qs -c noctalia-shell ipc call lockScreen lock

# Clear Noctalia cache (if having issues)
rm -rf ~/.cache/noctalia/
```

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
- 📶 Custom bluetooth scripts are included (`bluetooth-auto-switch.sh`, `install-bluetooth-auto-switch.sh`)
- 🎨 Themes and colors can be customized in individual config files
- 🌐 Browser CSS changes require browser restart to take effect
- 🛡️ uBlock Origin settings can be exported/imported for easy setup across devices
- 🪟 **NVIDIA users**: May need additional configuration for optimal Hyprland performance
- 🖥️ **Multi-monitor setups**: Configure displays in `~/.config/hypr/hyprland.conf`
- ⚡ **Performance**: Hyprland performs best with modern GPUs and drivers
- 🖥️ **Terminal choice**: Both Kitty and Wezterm configs included with Noctalia theme
- 🌙 **Noctalia Shell**: Replaces Waybar, SwayNC, and Mako - all-in-one desktop shell
- 🌙 **Noctalia config**: Stored in `~/.config/noctalia/` (not managed by stow)

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
- **[Noctalia Shell](https://github.com/noctalia-dev/noctalia-shell)** - Sleek and minimal desktop shell for Wayland
- **[Quickshell](https://quickshell.outfoxxed.me/)** - Building blocks for desktop shells
- **[Zen Browser](https://zen-browser.app/)** - Privacy-focused Firefox-based browser
- **[Nebula Theme](https://github.com/JustAdumbPrsn/Zen-Nebula)** - Beautiful cosmic theme for Zen Browser
- **[Starship](https://starship.rs/)** - Cross-platform prompt

---

**Crafted by RAINZ** • _Making Linux beautiful, one rice at a time_

⭐ **Star this repo if it helped you!**

**Made with ❤️ for the Arch Linux and Hyprland community**

</div>
