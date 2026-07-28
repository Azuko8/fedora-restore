#!/usr/bin/env bash

set -euo pipefail

case "${XDG_CURRENT_DESKTOP:-}" in
    KDE*)
       curl -fsSL \
            https://raw.githubusercontent.com/Azuko8/fedora-restore/main/profiles/fedorakde.sh \
            | bash
            ;;
    GNOME*)
        curl -fsSL \
            https://raw.githubusercontent.com/Azuko8/fedora-restore/main/profiles/fedoraws.sh \
            | bash
            ;;
    Cinnamon*)
        curl -fsSL \
            https://raw.githubusercontent.com/Azuko8/fedora-restore/main/profiles/fedoracinnamon.sh \
            | bash
            ;;
    COSMIC*)
        curl -fsSL \
            https://raw.githubusercontent.com/Azuko8/fedora-restore/main/profiles/fedoracosmic.sh \
            | bash
            ;;
    *)
        echo "Unsupported desktop."
        exit 1
        ;;
esac
