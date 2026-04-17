#!/bin/bash

# ==========================================
# RAINZ's Arch Hyprland Rice Installer (Ultimate Edition)
# ==========================================

# ------------------------------------------
# 🎨 UI & THEME CONFIGURATION (Tokyo Night Inspired)
# ------------------------------------------
COLOR_PRIMARY="#7aa2f7"   # Blue
COLOR_SECONDARY="#bb9af7" # Purple
COLOR_ACCENT="#7dcfff"    # Cyan
COLOR_SUCCESS="#9ece6a"   # Green
COLOR_ERROR="#f7768e"     # Red
COLOR_WARNING="#e0af68"   # Yellow
COLOR_TEXT="#c0caf5"      # Light Gray
COLOR_BG="#1a1b26"        # Dark Background

UI_WIDTH=80 # Slightly wider for a breathable layout

# ------------------------------------------
# 🔐 SUDO CACHE
# ------------------------------------------
clear
gum style --foreground "$COLOR_WARNING" --bold "🔑 Requesting administrative privileges..."
sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &
SUDO_PID=$!

# ------------------------------------------
# 🛡️ GLOBAL ERROR HANDLER
# ------------------------------------------
error_handler() {
  local line=$1
  local exit_code=$2
  kill $SUDO_PID 2>/dev/null
  clear
  gum style --margin "1 auto" --width "$UI_WIDTH" --border rounded --border-foreground "$COLOR_ERROR" --padding "1 2" \
    "$(gum style --foreground "$COLOR_ERROR" --bold "💥 CRITICAL ERROR")
    
Script crashed on line $line (Exit Code: $exit_code)

$(gum style --foreground "$COLOR_WARNING" "Don't panic! Here is how to recover:")
1. Package download failed? Run: $(gum style --foreground "$COLOR_ACCENT" "sudo pacman -Sy archlinux-keyring && sudo pacman -Syu")
2. Git clone failed? Check your internet connection.

Fix the issue and run this script again. $(gum style --foreground "$COLOR_SUCCESS" "It is completely safe to re-run.")"
  exit $exit_code
}

set -e
trap 'error_handler ${LINENO} $?' ERR

# ------------------------------------------
# 💅 UI HELPER FUNCTIONS
# ------------------------------------------
print_header() {
  clear
  gum style \
    --border double \
    --align center --width "$UI_WIDTH" --margin "1 auto" --padding "1 2" \
    --border-foreground "$COLOR_SECONDARY" --foreground "$COLOR_ACCENT" --bold \
    "✨ RAINZ's ARCH HYPRLAND SETUP ✨" \
    "$(gum style --foreground "$COLOR_TEXT" --faint "A meticulously crafted Wayland experience")"
}

print_step() {
  gum style --margin "1 0 0 0" --padding "0 2" --background "$COLOR_PRIMARY" --foreground "$COLOR_BG" --bold " $1 "
}

print_info() {
  gum style --margin "0 0 0 2" --foreground "$COLOR_ACCENT" "ℹ️ $1"
}

print_success() {
  gum style --margin "0 0 0 2" --foreground "$COLOR_SUCCESS" "✓ $1"
}

print_error() {
  gum style --margin "0 0 0 2" --foreground "$COLOR_ERROR" "✖ $1"
}

# ------------------------------------------
# 📦 SMART INSTALLATION WRAPPERS
# ------------------------------------------
install_pacman() {
  local missing=""
  for pkg in $1; do
    if ! pacman -Qq "$pkg" &>/dev/null; then
      missing="$missing $pkg"
    fi
  done

  missing=$(echo "$missing" | xargs)

  if [ -z "$missing" ]; then
    print_success "Already installed: $1"
    return 0
  fi

  print_info "Missing packages: $missing"

  if ! gum spin --spinner dot --spinner.foreground "$COLOR_SECONDARY" --title " Installing via pacman..." -- sudo pacman -S --needed --noconfirm $missing >/dev/null 2>&1; then
    print_error "Pacman failed. Running openly to show the error:"
    sudo pacman -S --needed --noconfirm $missing
    exit 1
  fi
}

install_aur() {
  local missing=""
  for pkg in $1; do
    if ! pacman -Qq "$pkg" &>/dev/null; then
      missing="$missing $pkg"
    fi
  done

  missing=$(echo "$missing" | xargs)

  if [ -z "$missing" ]; then
    print_success "Already installed (AUR): $1"
    return 0
  fi

  print_info "Missing AUR packages: $missing"

  if ! gum spin --spinner dot --spinner.foreground "$COLOR_SECONDARY" --title " Installing via yay..." -- yay -S --needed --noconfirm $missing >/dev/null 2>&1; then
    print_error "Yay failed. Running openly to show the error:"
    yay -S --needed --noconfirm $missing
    exit 1
  fi
}

# ==========================================
# 0. BOOTSTRAP (Silent/Required)
# ==========================================
clear
gum spin --spinner line --spinner.foreground "$COLOR_ACCENT" --title " Checking system requirements..." -- sleep 1

if [ ! -d "$HOME/dotfiles" ]; then
  gum style --foreground "$COLOR_ERROR" --bold "[!] Error: ~/dotfiles directory not found."
  gum style --foreground "$COLOR_TEXT" "Please clone your dotfiles repository to your home folder first."
  exit 1
fi

sudo pacman -S --needed --noconfirm base-devel git curl wget unzip stow >/dev/null 2>&1

if ! command -v gum &>/dev/null; then
  echo -e "\e[34mInstalling 'gum' for UI components...\e[0m"
  if ! sudo pacman -S --needed gum --noconfirm; then
    echo -e "\e[31m[!] Failed to install 'gum'. Please check your internet connection or pacman lock.\e[0m"
    exit 1
  fi
fi

# ==========================================
# 1. INSTALLATION MODE SELECTION
# ==========================================
print_header

print_step "⚙️ INSTALLATION MODE"
INSTALL_MODE=$(gum choose --cursor="❯ " --cursor.foreground="$COLOR_ACCENT" --item.foreground="$COLOR_TEXT" --selected.foreground="$COLOR_SUCCESS" \
  "🚀 Express (Install EVERYTHING automatically)" \
  "🛠️ Custom (Step-by-step granular selection)")

print_step "🎮 GPU DRIVER (Mandatory)"
GPU_CHOICE=$(gum choose --cursor="❯ " --cursor.foreground="$COLOR_ACCENT" --item.foreground="$COLOR_TEXT" --selected.foreground="$COLOR_SUCCESS" \
  "NVIDIA" "AMD" "Intel" "Skip (Already Installed)")

if [[ "$INSTALL_MODE" == *"Express"* ]]; then
  print_step "🚀 EXPRESS MODE ACTIVE"
  print_info "Buckle up! All features will be installed."
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
  print_step "🔄 SYSTEM MAINTENANCE"
  gum style --margin "0 0 0 2" "Perform a full system update?"
  DO_UPDATE=$(gum confirm --selected.background="$COLOR_PRIMARY" --selected.foreground="$COLOR_BG" && echo "yes" || echo "no")

  print_step "🪟 CORE DESKTOP ELEMENTS"
  gum style --margin "0 0 0 2" "1. Install Hyprland & Wayland base?"
  INSTALL_HYPR=$(gum confirm --selected.background="$COLOR_PRIMARY" --selected.foreground="$COLOR_BG" && echo "yes" || echo "no")

  gum style --margin "0 0 0 2" "2. Install Noctalia Shell (Bar, Notifications)?"
  INSTALL_NOCT=$(gum confirm --selected.background="$COLOR_PRIMARY" --selected.foreground="$COLOR_BG" && echo "yes" || echo "no")

  gum style --margin "0 0 0 2" "3. Install Audio Subsystem (Pipewire)?"
  INSTALL_AUDIO=$(gum confirm --selected.background="$COLOR_PRIMARY" --selected.foreground="$COLOR_BG" && echo "yes" || echo "no")

  gum style --margin "0 0 0 2" "4. Install Bluetooth Subsystem (Bluez)?"
  INSTALL_BT=$(gum confirm --selected.background="$COLOR_PRIMARY" --selected.foreground="$COLOR_BG" && echo "yes" || echo "no")

  gum style --margin "0 0 0 2" "5. Install Nerd Fonts & Starship Prompt?"
  INSTALL_FONTS=$(gum confirm --selected.background="$COLOR_PRIMARY" --selected.foreground="$COLOR_BG" && echo "yes" || echo "no")

  print_step "📦 EXTRA APPLICATIONS"
  EXTRAS=$(gum choose --no-limit --cursor-prefix "( ) " --selected-prefix "(x) " --unselected-prefix "( ) " \
    --cursor.foreground="$COLOR_ACCENT" --selected.foreground="$COLOR_SUCCESS" --item.foreground="$COLOR_TEXT" \
    "Ghostty" "Kitty" "Wezterm" "Zen Browser" "Yazi" "Zathura" "Fetch Tools")

  print_step "✏️ DEVELOPMENT ENVIRONMENT"
  gum style --margin "0 0 0 2" "Install RAINZ's custom Neovim setup?"
  WANT_NVIM=$(gum confirm --selected.background="$COLOR_PRIMARY" --selected.foreground="$COLOR_BG" && echo "yes" || echo "no")
fi

# ==========================================
# 2. 🛡️ PRE-FLIGHT BACKUP
# ==========================================
print_header
gum style --align center --width "$UI_WIDTH" --margin "0 auto" --foreground "$COLOR_SUCCESS" --bold "🚀 COMMENCING INSTALLATION..."

BACKUP_DIR="$HOME/.config.bak_$(date +%Y%m%d_%H%M%S)"
gum spin --spinner points --spinner.foreground "$COLOR_SECONDARY" --title " Backing up existing configs to $BACKUP_DIR..." -- sleep 2
mkdir -p "$BACKUP_DIR"

TARGET_CONFIGS=("nvim" "fish" "starship" "rofi" "hypr" "noctalia" "tmux" "ghostty" "kitty" "wezterm" "yazi" "zathura" "bat" "fastfetch")
for app in "${TARGET_CONFIGS[@]}"; do
  if [ -d "$HOME/.config/$app" ]; then
    cp -r "$HOME/.config/$app" "$BACKUP_DIR/" 2>/dev/null || true
  fi
done

# ==========================================
# 3. EXECUTION PHASE
# ==========================================

if [[ "$DO_UPDATE" == "yes" ]]; then
  print_step "🔄 SYSTEM UPDATE"
  gum spin --spinner dot --spinner.foreground "$COLOR_ACCENT" --title " Syncing Arch mirrors..." -- sudo pacman -Syu --noconfirm >/dev/null 2>&1
  print_success "System is up to date."
fi

if ! command -v yay &>/dev/null; then
  print_step "📦 COMPILING AUR HELPER"
  gum spin --spinner dot --spinner.foreground "$COLOR_ACCENT" --title " Building yay..." -- bash -c "rm -rf /tmp/yay && git clone https://aur.archlinux.org/yay.git /tmp/yay >/dev/null 2>&1 && cd /tmp/yay && makepkg -si --noconfirm"
  cd ~/dotfiles
fi

print_step "🎮 GPU DRIVERS ($GPU_CHOICE)"
case $GPU_CHOICE in
"NVIDIA") install_pacman "nvidia nvidia-utils nvidia-settings" ;;
"AMD") install_pacman "mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon" ;;
"Intel") install_pacman "mesa lib32-mesa vulkan-intel lib32-vulkan-intel" ;;
*) print_info "Skipping GPU drivers." ;;
esac

if [[ "$INSTALL_HYPR" == "yes" ]]; then
  print_step "🪟 WINDOW MANAGER"
  install_pacman "hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal-gtk wayland wlroots rofi-wayland hyprpaper thunar tmux brightnessctl"
fi

if [[ "$INSTALL_NOCT" == "yes" ]]; then
  print_step "🌙 NOCTALIA SHELL"
  install_aur "noctalia-shell vicinae"
fi

if [[ "$INSTALL_AUDIO" == "yes" ]]; then
  print_step "🔊 AUDIO SUBSYSTEM"
  install_pacman "pipewire pipewire-pulse pipewire-alsa wireplumber pavucontrol"
fi

if [[ "$INSTALL_BT" == "yes" ]]; then
  print_step "📶 BLUETOOTH"
  install_pacman "bluez bluez-utils blueman"
fi

if [[ "$INSTALL_FONTS" == "yes" ]]; then
  print_step "🔤 TYPOGRAPHY & TERMINAL"
  install_pacman "ttf-jetbrains-mono-nerd starship fish"
fi

print_step "📦 EXTRA APPLICATIONS"
if [ -z "$EXTRAS" ]; then
  print_info "No extras selected."
else
  if [[ $EXTRAS == *"Ghostty"* ]]; then sudo pacman -S --needed --noconfirm ghostty >/dev/null 2>&1 || install_aur "ghostty-git"; fi
  if [[ $EXTRAS == *"Kitty"* ]]; then install_pacman "kitty"; fi
  if [[ $EXTRAS == *"Wezterm"* ]]; then install_pacman "wezterm"; fi
  if [[ $EXTRAS == *"Zen Browser"* ]]; then install_aur "zen-browser-bin"; fi
  if [[ $EXTRAS == *"Yazi"* ]]; then install_pacman "yazi"; fi
  if [[ $EXTRAS == *"Zathura"* ]]; then install_pacman "zathura zathura-pdf-mupdf"; fi
  if [[ $EXTRAS == *"Fetch Tools"* ]]; then install_aur "bat fastfetch kotofetch"; fi
fi

if [[ "$WANT_NVIM" == "yes" ]]; then
  print_step "✏️ NEOVIM ENVIRONMENT"
  install_pacman "neovim wl-clipboard ripgrep fd nodejs npm gcc"
  rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
  gum spin --spinner dot --spinner.foreground "$COLOR_ACCENT" --title " Fetching RAINZ configuration..." -- git clone https://github.com/R7rainz/neovim-conf ~/.config/nvim >/dev/null 2>&1
  print_success "Neovim configured."
fi

# ==========================================
# 4. SAFE STOWING
# ==========================================
print_step "🔗 DEPLOYING DOTFILES"

safe_stow() {
  local app=$1
  if [ -d "$HOME/dotfiles/$app" ]; then
    # || true prevents stow errors from triggering the set -e crash trap
    gum spin --spinner mini --spinner.foreground "$COLOR_SECONDARY" --title " Stowing $app..." -- stow --adopt "$app" >/dev/null 2>&1 || true
  fi
}

cd ~/dotfiles || exit 1

if [[ "$INSTALL_FONTS" == "yes" ]]; then safe_stow fish && safe_stow starship; fi
if [[ "$INSTALL_HYPR" == "yes" ]]; then safe_stow rofi && safe_stow hyprland && safe_stow tmux; fi
if [[ "$INSTALL_NOCT" == "yes" ]]; then safe_stow noctalia; fi
if [[ $EXTRAS == *"Ghostty"* ]]; then safe_stow ghostty; fi
if [[ $EXTRAS == *"Kitty"* ]]; then safe_stow kitty; fi
if [[ $EXTRAS == *"Wezterm"* ]]; then safe_stow wezterm; fi
if [[ $EXTRAS == *"Yazi"* ]]; then safe_stow yazi; fi
if [[ $EXTRAS == *"Zathura"* ]]; then safe_stow zathura; fi
if [[ $EXTRAS == *"Fetch Tools"* ]]; then safe_stow bat && safe_stow fastfetch; fi

git restore . >/dev/null 2>&1 || true
print_success "Symlinks created successfully."

# ==========================================
# 5. SYSTEM SERVICES
# ==========================================
print_step "⚙️ SYSTEM SERVICES"

if [[ "$INSTALL_AUDIO" == "yes" ]]; then
  systemctl --user enable --now pipewire pipewire-pulse wireplumber >/dev/null 2>&1 || true
  print_success "Audio services enabled."
fi

if [[ "$INSTALL_BT" == "yes" ]]; then
  sudo systemctl enable bluetooth >/dev/null 2>&1 || true
  print_success "Bluetooth daemon enabled."
fi

if [[ "$INSTALL_FONTS" == "yes" ]]; then
  if ! grep -q "/usr/bin/fish" /etc/shells; then
    echo /usr/bin/fish | sudo tee -a /etc/shells >/dev/null
  fi
  sudo chsh -s /usr/bin/fish "$USER" >/dev/null 2>&1 || true
  print_success "Default shell set to Fish."
fi

# ==========================================
# 6. COMPLETION
# ==========================================
trap - ERR
kill $SUDO_PID 2>/dev/null || true

clear
gum style \
  --border double --border-foreground "$COLOR_SUCCESS" \
  --align center --width "$UI_WIDTH" --margin "1 auto" --padding "1 2" \
  "$(gum style --foreground "$COLOR_SUCCESS" --bold "🎉 INSTALLATION COMPLETE! 🎉")" \
  "" \
  "$(gum style --foreground "$COLOR_TEXT" "Your Wayland environment has been meticulously crafted.")" \
  "$(gum style --foreground "$COLOR_TEXT" "Please reboot your system to apply all shell and service changes.")" \
  "" \
  "$(gum style --foreground "$COLOR_WARNING" "Backups saved to:")" \
  "$(gum style --foreground "$COLOR_ACCENT" "$BACKUP_DIR")"

echo ""
