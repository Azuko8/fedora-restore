#!/usr/bin/env bash
set -euo pipefail

desktop="${XDG_CURRENT_DESKTOP:-}"

case "$desktop" in
    KDE*)
        profile="fedorakde.sh"
        ;;
    GNOME*)
        profile="fedoraws.sh"
        ;;
    X-Cinnamon*|Cinnamon*)
        profile="fedoracinnamon.sh"
        ;;
    COSMIC*)
        profile="fedoracosmic.sh"
        ;;
    *)
        echo "Unsupported desktop."
        echo "XDG_CURRENT_DESKTOP=${XDG_CURRENT_DESKTOP:-<unset>}"
        echo "XDG_SESSION_DESKTOP=${XDG_SESSION_DESKTOP:-<unset>}"
        echo "DESKTOP_SESSION=${DESKTOP_SESSION:-<unset>}"
        exit 1
        ;;
esac

curl -fsSL "https://raw.githubusercontent.com/Azuko8/fedora-restore/main/profiles/$profile" | bash
