#!/usr/bin/env bash

# Fedora Workstation Setup Script
# Removes bloat and installs stuff I need
# For personal use on Fedora 44 (Workstation)

set -euo pipefail

echo "=========================================="
echo "Fedora Workstation Setup Script"
echo "=========================================="
echo ""
echo "OS: Fedora 44 (Workstation)"
echo ""
echo "Software to be installed manually post-script:"
echo "  • Signal"
echo "  • Vesktop"
echo "  • osu!"
echo "  • pear-desktop"
echo ""
echo "=========================================="
echo ""

echo "Removing bloat"
echo ""

REMOVE_PACKAGES=(
    firefox
    thunderbird #forgot if it comes with WS, but just in case
    gnome-contacts
    
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

if sudo dnf install -y fish kitty steam; then
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
    echo "Flathub source added."
else
    echo "Error: Flathub configuration failed."
    exit 1
fi

echo ""

echo "Installing Flatpak packages..."
echo ""

if flatpak install -y flathub \
    com.notesnook.Notesnook \
    com.obsproject.Studio \
    io.github.Foldex.AdwSteamGtk \
    io.gitlab.librewolf-community \
    it.mijorus.gearlever \
    net.davidotek.pupgui2 \
    org.fedoraproject.MediaWriter \
    org.prismlauncher.PrismLauncher; then
    echo "Flatpak packages installed successfully."
else
    echo "Error: Flatpak installation failed."
    exit 1
fi

echo ""

echo "=========================================="
echo "Setup complete."
echo "=========================================="
echo ""
echo "Remember to install these manually:"
echo "  • Signal"
echo "  • Vesktop"
echo "  • osu!"
echo "  • pear-desktop"
echo ""
