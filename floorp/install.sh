#!/bin/bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

error() { echo -e "${RED}[ERROR]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
ok() { echo -e "${GREEN}[OK]${NC} $1"; }

# Check root
[[ $EUID -eq 0 ]] && { error "Don't run as root"; exit 1; }

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check required files
REQUIRED_FILES=("user.js" "policies_json.json" "mimeapps.list" "search.json.mozlz4")
for file in "${REQUIRED_FILES[@]}"; do
    [[ ! -f "$SCRIPT_DIR/$file" ]] && { error "Missing: $file"; exit 1; }
done

# Find Floorp profile directory
FLOORP_DIRS=("$HOME/.floorp" "$HOME/.mozilla/floorp" "$HOME/snap/floorp/common/.floorp" "$HOME/.var/app/one.ablaze.floorp/.floorp")
FLOORP_PROFILES_DIR=""

for dir in "${FLOORP_DIRS[@]}"; do
    if [[ -d "$dir" ]]; then
        FLOORP_PROFILES_DIR="$dir"
        break
    fi
done

# Create if not found
[[ -z "$FLOORP_PROFILES_DIR" ]] && {
    FLOORP_PROFILES_DIR="$HOME/.floorp"
    mkdir -p "$FLOORP_PROFILES_DIR"
}

# Find or create profile
PROFILE_DIR=""
if [[ -f "$FLOORP_PROFILES_DIR/profiles.ini" ]]; then
    while IFS= read -r line; do
        if [[ $line == Path=* ]]; then
            profile_path="${line#Path=}"
            if [[ -d "$FLOORP_PROFILES_DIR/$profile_path" ]]; then
                PROFILE_DIR="$FLOORP_PROFILES_DIR/$profile_path"
                break
            fi
        fi
    done < "$FLOORP_PROFILES_DIR/profiles.ini"
fi

# Look for existing profile if profiles.ini didn't work
[[ -z "$PROFILE_DIR" ]] && {
    for dir in "$FLOORP_PROFILES_DIR"/*; do
        if [[ -d "$dir" && -f "$dir/prefs.js" ]]; then
            PROFILE_DIR="$dir"
            break
        fi
    done
}

# Create new profile if none found
[[ -z "$PROFILE_DIR" ]] && {
    PROFILE_DIRNAME="$(date +%s).elena"
    PROFILE_DIR="$FLOORP_PROFILES_DIR/$PROFILE_DIRNAME"
    mkdir -p "$PROFILE_DIR"
    
    cat > "$FLOORP_PROFILES_DIR/profiles.ini" << EOF
[General]
StartWithLastProfile=1
Version=2

[Profile0]
Name=elena
IsRelative=1
Path=$PROFILE_DIRNAME
Default=1
EOF
}

# Install files
[[ -f "$PROFILE_DIR/user.js" ]] && cp "$PROFILE_DIR/user.js" "$PROFILE_DIR/user.js.backup.$(date +%s)"
[[ -f "$PROFILE_DIR/search.json.mozlz4" ]] && cp "$PROFILE_DIR/search.json.mozlz4" "$PROFILE_DIR/search.json.mozlz4.backup.$(date +%s)"
[[ -f "$HOME/.config/mimeapps.list" ]] && cp "$HOME/.config/mimeapps.list" "$HOME/.config/mimeapps.list.backup.$(date +%s)"

cp "$SCRIPT_DIR/user.js" "$PROFILE_DIR/"
cp "$SCRIPT_DIR/search.json.mozlz4" "$PROFILE_DIR/"
mkdir -p "$HOME/.config"
cp "$SCRIPT_DIR/mimeapps.list" "$HOME/.config/"

# Create wallpapers directory
mkdir -p "$HOME/Pictures/wallpapers"

ok "Installed to profile: $(basename "$PROFILE_DIR")"
warn "Manually install policies_json.json to /etc/floorp/policies/policies.json"
echo "sudo mkdir -p /etc/floorp/policies && sudo cp $SCRIPT_DIR/policies_json.json /etc/floorp/policies/policies.json"
