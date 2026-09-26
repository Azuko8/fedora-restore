#!/usr/bin/env bash

# Fedora Cinnamon Setup Script
# Removes bloat and installs stuff I need
# For personal use on Fedora 44 (Cinnamon)

set -euo pipefail

echo "=========================================="
echo "Fedora Cinnamon Setup Script"
echo "=========================================="
echo ""
echo "OS: Fedora 44 (Cinnamon)"
echo ""
echo "Software to be installed manually post-script:"
echo "  • Vesktop"
echo "  • osu!"
echo "  • ytm"
echo ""
echo "=========================================="
echo ""

echo "Removing bloat"
echo ""

REMOVE_PACKAGES=(
    firefox
    exaile
    xed
    hexchat
    pidgin
    xfburn
    gnome-software
)

echo "Removing ${#REMOVE_PACKAGES[@]} packages..."
if sudo dnf remove "${REMOVE_PACKAGES[@]}" -y; then
    echo "Packages removed successfully."
else
    echo "Error: Package removal failed."
    exit 1
fi

echo ""

echo "Installing dnf packages..."
echo ""

if sudo dnf install -y fish kitty git micro steam obs-studio btrfs-assistant solaar timeshift > /dev/null; then
    echo "dnf packages installed successfully."
else
    echo "Error: dnf installation failed."
    exit 1
fi

echo ""

echo "Configuring Flatpak..."
echo ""

echo "Checking and adding flathub source if not present..."
if flatpak remote-add --if-not-exists flathub \
    https://dl.flathub.org/repo/flathub.flatpakrepo; then
    echo "Flathub configured."
else
    echo "Error: Flathub configuration failed."
    exit 1
fi

echo ""

echo "Installing Flatpak packages..."
echo ""

if flatpak install -y flathub \
    org.keepassxc.KeePassXC \
    it.mijorus.gearlever \
    net.davidotek.pupgui2 \
    io.github.debasish_patra_1987.linuxthemestore \
    io.github.kolunmi.Bazaar \
    org.localsend.localsend_app \
    org.prismlauncher.PrismLauncher \
    com.github.tchx84.Flatseal > /dev/null; then
    echo "Flatpak packages installed successfully."
else
    echo "Error: Flatpak installation failed."
    exit 1
fi

echo "Adding LibreWolf third party repo..."

if sudo dnf config-manager addrepo --from-repofile=https://repo.librewolf.net/librewolf.repo; then
    echo "LibreWolf repo added successfully."
else
    echo "Error: LibreWolf repository configuration failed."
    exit 1
fi

echo ""
echo "Installing LibreWolf..."

if sudo dnf install -y librewolf > /dev/null; then
    echo "LibreWolf installed successfully."
else
    echo "Error: LibreWolf installation failed."
    exit 1
fi

echo "Installing Signal..."

mkdir -p "$HOME/.local/bin"

if curl -L -o "$HOME/.local/bin/signal-desktop.AppImage" \
    https://updates.signal.org/desktop/signal-desktop.AppImage > /dev/null; then
    echo "Signal AppImage downloaded successfully."
else
    echo "Error: Signal download failed."
    exit 1
fi

echo "Verifying Signal AppImage..."

if curl -o /tmp/signal-appimage.asc \
    https://updates.signal.org/static/desktop/appimage.asc > /dev/null &&
   curl -L -o /tmp/signal-desktop.AppImage.gpg \
    https://updates.signal.org/desktop/signal-desktop.AppImage.gpg > /dev/null &&
   gpg --import /tmp/signal-appimage.asc > /dev/null &&
   gpg --verify /tmp/signal-desktop.AppImage.gpg \
    "$HOME/.local/bin/signal-desktop.AppImage" > /dev/null; then
    echo "Signal AppImage verified successfully."
else
    echo "Error: Signal AppImage verification failed."
    exit 1
fi

chmod +x "$HOME/.local/bin/signal-desktop.AppImage"

rm -f /tmp/signal-appimage.asc \
      /tmp/signal-desktop.AppImage.gpg

echo "Signal installed successfully."

echo ""

echo "=========================================="
echo "Setup complete."
echo "=========================================="
echo ""
echo "Remember to install these manually:"
echo "  • Vesktop"
echo "  • osu!"
echo "  • ytm"
echo ""
