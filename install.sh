#!/bin/bash

# ==========================================
# RAINZ's Arch Hyprland Rice Installer (Ultimate Edition)
# ==========================================

# ------------------------------------------
# 🎨 UI & STYLING UTILITIES
# ------------------------------------------
TITLE_COLOR="#A8AEFF"
ACCENT_COLOR="#EEB8CB"
ERROR_COLOR="#FF6B6B"
SUCCESS_COLOR="#51CF66"
UI_WIDTH=75 # Fixed width for a clean, contained "App Window" look

# ------------------------------------------
# 🔐 SUDO CACHE (Prevents spinners from breaking)
# ------------------------------------------
# Ask for the administrator password upfront so background tasks don't hang
sudo -v
# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# ------------------------------------------
# 🛡️ GLOBAL ERROR HANDLER
# ------------------------------------------
error_handler() {
  local line=$1
  local exit_code=$2
  clear
  gum style --margin "1 auto" --width "$UI_WIDTH" --foreground "$ERROR_COLOR" --bold "💥 CRITICAL ERROR: Script crashed on line $line (Exit Code: $exit_code)"
  gum style --margin "0 auto" --width "$UI_WIDTH" --foreground "$ACCENT_COLOR" "Don't panic! Here is how to recover:"
  gum style --margin "0 auto" --width "$UI_WIDTH" "1. If a package download failed, run: sudo pacman -Sy archlinux-keyring && sudo pacman -Syu"
  gum style --margin "0 auto" --width "$UI_WIDTH" "2. If a git clone failed, check your internet connection."
  gum style --margin "1 auto" --width "$UI_WIDTH" --foreground "$ACCENT_COLOR" "Fix the error manually and run this script again. It is safe to re-run."
  exit $exit_code
}

set -e
trap 'error_handler ${LINENO} $?' ERR

# ------------------------------------------
# 📦 INSTALLATION WRAPPERS (With Loading Animations)
# ------------------------------------------
install_pacman() {
  if ! gum spin --spinner dot --title " Installing via pacman: $1..." -- sudo pacman -S --needed --noconfirm $1 >/dev/null 2>&1; then
    gum style --margin "0 auto" --width "$UI_WIDTH" --foreground "$ERROR_COLOR" "[!] Failed to install: $1"
    exit 1
  fi
}

install_aur() {
  if ! gum spin --spinner dot --title " Installing via yay: $1..." -- yay -S --needed --noconfirm $1 >/dev/null 2>&1; then
    gum style --margin "0 auto" --width "$UI_WIDTH" --foreground "$ERROR_COLOR" "[!] Failed to install AUR package: $1"
    exit 1
  fi
}

print_header() {
  clear
  gum style \
    --border double \
    --align center --width "$UI_WIDTH" --margin "1 auto" --padding "1 2" \
    --border-foreground "$TITLE_COLOR" --foreground "$ACCENT_COLOR" \
    "✨ RAINZ's ARCH HYPRLAND SETUP ✨" "A meticulously crafted Wayland experience"
}

print_step() {
  echo ""
  gum style --margin "0 auto" --width "$UI_WIDTH" --foreground "$TITLE_COLOR" --bold "$1"
}

# ==========================================
# 0. BOOTSTRAP (Silent/Required)
# ==========================================
clear
echo -e "\e[34m[Bootstrapping...] Checking for essential packages (base-devel, git, gum)...\e[0m"
sudo pacman -S --needed --noconfirm base-devel git curl wget unzip >/dev/null 2>&1

if ! command -v gum &>/dev/null; then
  sudo pacman -S --needed gum --noconfirm >/dev/null 2>&1
fi

# ==========================================
# 1. INSTALLATION MODE SELECTION
# ==========================================
print_header

print_step "⚙️  Select Installation Mode"
INSTALL_MODE=$(gum choose --cursor.foreground="$ACCENT_COLOR" "🚀 Express (Install EVERYTHING automatically)" "🛠️ Custom (Step-by-step granular selection)")

print_step "🎮 STEP 1: Select your GPU Driver (Mandatory)"
GPU_CHOICE=$(gum choose --cursor.foreground="$ACCENT_COLOR" "NVIDIA" "AMD" "Intel" "Skip (Already Installed)")

# Setup variables based on mode
if [[ "$INSTALL_MODE" == *"Express"* ]]; then
  print_step "🚀 Express Mode Active: All features will be installed."
  sleep 2
  DO_UPDATE="yes"
  INSTALL_HYPR="yes"
  INSTALL_NOCT="yes"
  INSTALL_AUDIO="yes"
  INSTALL_BT="yes"
  INSTALL_FONTS="yes"
  EXTRAS="Ghostty Kitty Wezterm Zen Browser Yazi Zathura Fetch Tools"
  WANT_NVIM="yes"
else
  # ------------------------------------------
  # CUSTOM GRANULAR PROMPTS
  # ------------------------------------------
  print_step "🔄 STEP 2: System Maintenance - Perform a full system update?"
  DO_UPDATE=$(gum confirm --selected.background="$TITLE_COLOR" && echo "yes" || echo "no")

  print_step "🪟 STEP 3: Core Desktop Elements"
  INSTALL_HYPR=$(gum confirm "1. Install Hyprland & Wayland base?" --selected.background="$TITLE_COLOR" && echo "yes" || echo "no")
  INSTALL_NOCT=$(gum confirm "2. Install Noctalia Shell (Bar, Notifications)?" --selected.background="$TITLE_COLOR" && echo "yes" || echo "no")
  INSTALL_AUDIO=$(gum confirm "3. Install Audio Subsystem (Pipewire)?" --selected.background="$TITLE_COLOR" && echo "yes" || echo "no")
  INSTALL_BT=$(gum confirm "4. Install Bluetooth Subsystem (Bluez)?" --selected.background="$TITLE_COLOR" && echo "yes" || echo "no")
  INSTALL_FONTS=$(gum confirm "5. Install Nerd Fonts & Starship Prompt?" --selected.background="$TITLE_COLOR" && echo "yes" || echo "no")

  print_step "📦 STEP 4: Choose Extra Applications"
  EXTRAS=$(gum choose --no-limit --cursor-prefix "❯ " --selected-prefix "◉ " --unselected-prefix "○ " --cursor.foreground="$ACCENT_COLOR" --selected.foreground="$SUCCESS_COLOR" \
    "Ghostty" "Kitty" "Wezterm" "Zen Browser" "Yazi" "Zathura" "Fetch Tools")

  print_step "✏️  STEP 5: Install RAINZ's custom Neovim setup?"
  WANT_NVIM=$(gum confirm --selected.background="$TITLE_COLOR" && echo "yes" || echo "no")
fi

# ==========================================
# 2. 🛡️ PRE-FLIGHT BACKUP
# ==========================================
print_header
gum style --align center --width "$UI_WIDTH" --margin "0 auto" --foreground "$SUCCESS_COLOR" "🚀 STARTING INSTALLATION PHASE..."

BACKUP_DIR="$HOME/.config.bak_$(date +%Y%m%d_%H%M%S)"
gum spin --spinner line --title " 🛡️ Backing up targeted configs to $BACKUP_DIR..." -- sleep 1
mkdir -p "$BACKUP_DIR"

TARGET_CONFIGS=("nvim" "fish" "starship" "rofi" "hypr" "tmux" "ghostty" "kitty" "wezterm" "yazi" "zathura" "bat" "fastfetch")
for app in "${TARGET_CONFIGS[@]}"; do
  if [ -d "$HOME/.config/$app" ]; then
    cp -r "$HOME/.config/$app" "$BACKUP_DIR/" 2>/dev/null || true
  fi
done

# ==========================================
# 3. EXECUTION PHASE
# ==========================================

# --- SYSTEM UPDATE ---
if [[ "$DO_UPDATE" == "yes" ]]; then
  print_step "🔄 System Update"
  gum spin --spinner dot --title " Updating Arch Linux mirrors and packages..." -- sudo pacman -Syu --noconfirm >/dev/null 2>&1
fi

# --- YAY INSTALL ---
if ! command -v yay &>/dev/null; then
  print_step "📦 AUR Helper"
  gum spin --spinner dot --title " Cloning and compiling yay..." -- bash -c "git clone https://aur.archlinux.org/yay.git /tmp/yay >/dev/null 2>&1 && cd /tmp/yay && makepkg -si --noconfirm >/dev/null 2>&1"
  cd ~/dotfiles
fi

# --- GPU DRIVERS ---
print_step "🎮 GPU Drivers ($GPU_CHOICE)"
case $GPU_CHOICE in
"NVIDIA") install_pacman "nvidia nvidia-utils nvidia-settings" ;;
"AMD") install_pacman "mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon" ;;
"Intel") install_pacman "mesa lib32-mesa vulkan-intel lib32-vulkan-intel" ;;
esac

# --- GRANULAR CORE COMPONENTS ---
if [[ "$INSTALL_HYPR" == "yes" ]]; then
  print_step "🪟 Core Window Manager"
  install_pacman "hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal-gtk wayland wlroots rofi hyprpaper thunar tmux stow brightnessctl"
fi

if [[ "$INSTALL_NOCT" == "yes" ]]; then
  print_step "🌙 Desktop Shell"
  install_aur "noctalia-shell avizo vicinae"
fi

if [[ "$INSTALL_AUDIO" == "yes" ]]; then
  print_step "🔊 Audio"
  install_pacman "pipewire pipewire-pulse wireplumber pulseaudio pavucontrol"
fi

if [[ "$INSTALL_BT" == "yes" ]]; then
  print_step "📶 Bluetooth"
  install_pacman "bluez-utils blueman"
fi

if [[ "$INSTALL_FONTS" == "yes" ]]; then
  print_step "🔤 Typography & Shell"
  install_pacman "ttf-jetbrains-mono-nerd starship fish"
fi

# --- EXTRAS ---
print_step "📦 Extra Applications"
if [[ $EXTRAS == *"Ghostty"* ]]; then sudo pacman -S --needed --noconfirm ghostty >/dev/null 2>&1 || install_aur "ghostty-git"; fi
if [[ $EXTRAS == *"Kitty"* ]]; then install_pacman "kitty"; fi
if [[ $EXTRAS == *"Wezterm"* ]]; then install_pacman "wezterm"; fi
if [[ $EXTRAS == *"Zen Browser"* ]]; then install_aur "zen-browser-bin"; fi
if [[ $EXTRAS == *"Yazi"* ]]; then install_pacman "yazi"; fi
if [[ $EXTRAS == *"Zathura"* ]]; then install_pacman "zathura zathura-pdf-mupdf"; fi
if [[ $EXTRAS == *"Fetch Tools"* ]]; then install_aur "bat fastfetch kotofetch"; fi

# --- NEOVIM ---
if [[ "$WANT_NVIM" == "yes" ]]; then
  print_step "✏️  Neovim Environment"
  install_pacman "neovim wl-clipboard ripgrep fd nodejs npm gcc"
  rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
  gum spin --spinner dot --title " Cloning RAINZ Neovim configuration..." -- git clone https://github.com/R7rainz/neovim-conf ~/.config/nvim >/dev/null 2>&1
fi

# ==========================================
# 4. SAFE STOWING
# ==========================================
print_step "🔗 Symlinking Dotfiles"

safe_stow() {
  local app=$1
  if [ -d "$HOME/dotfiles/$app" ]; then
    gum spin --spinner line --title " Stowing $app..." -- stow --adopt "$app" >/dev/null 2>&1
  fi
}

cd ~/dotfiles || exit 1

if [[ "$INSTALL_FONTS" == "yes" ]]; then
  safe_stow fish
  safe_stow starship
fi
if [[ "$INSTALL_HYPR" == "yes" ]]; then
  safe_stow rofi
  safe_stow hyprland
  safe_stow tmux
fi
if [[ $EXTRAS == *"Ghostty"* ]]; then safe_stow ghostty; fi
if [[ $EXTRAS == *"Kitty"* ]]; then safe_stow kitty; fi
if [[ $EXTRAS == *"Wezterm"* ]]; then safe_stow wezterm; fi
if [[ $EXTRAS == *"Yazi"* ]]; then safe_stow yazi; fi
if [[ $EXTRAS == *"Zathura"* ]]; then safe_stow zathura; fi
if [[ $EXTRAS == *"Fetch Tools"* ]]; then
  safe_stow batfetch
  safe_stow fastfetch
fi

git restore . >/dev/null 2>&1 || true

# ==========================================
# 5. SYSTEM SERVICES
# ==========================================
print_step "⚙️  Enabling System Services"

if [[ "$INSTALL_AUDIO" == "yes" ]]; then
  systemctl --user enable --now pipewire pipewire-pulse wireplumber >/dev/null 2>&1 || true
fi

if [[ "$INSTALL_BT" == "yes" ]]; then
  sudo systemctl enable bluetooth >/dev/null 2>&1 || true
fi

if [[ "$INSTALL_FONTS" == "yes" ]]; then
  if ! grep -q "/usr/bin/fish" /etc/shells; then
    echo /usr/bin/fish | sudo tee -a /etc/shells >/dev/null
  fi
  sudo chsh -s /usr/bin/fish "$USER" >/dev/null 2>&1 || true
fi

# ==========================================
# 6. COMPLETION
# ==========================================
trap - ERR

print_header
gum style \
  --align center --width "$UI_WIDTH" --margin "1 auto" \
  --foreground "$SUCCESS_COLOR" --bold \
  "🎉 INSTALLATION COMPLETE! 🎉"
gum style --align center --width "$UI_WIDTH" --margin "0 auto" "Please reboot your system to apply all changes."
gum style --align center --width "$UI_WIDTH" --margin "1 auto" --foreground "$TITLE_COLOR" "Backups saved to: $BACKUP_DIR"
