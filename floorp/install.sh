#!/bin/bash
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

error() { echo -e "${RED}[ERROR]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
ok() { echo -e "${GREEN}[OK]${NC} $1"; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }

# Check root
if [[ $EUID -eq 0 ]]; then
    error "Don't run as root"
    exit 1
fi

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check required files
REQUIRED_FILES=("user.js" "policies.json" "mimeapps.list" "search.json.mozlz4")
for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f "$SCRIPT_DIR/$file" ]]; then
        error "Missing: $file"
        exit 1
    fi
done

# Function to forcefully apply user.js preferences
apply_userjs_preferences() {
    local profile_dir="$1"
    local userjs_file="$SCRIPT_DIR/user.js"
    local prefs_file="$profile_dir/prefs.js"
    local target_userjs="$profile_dir/user.js"

    info "Applying user.js preferences..."

    # Copy user.js to profile directory
    cp "$userjs_file" "$target_userjs"
    ok "Copied user.js to profile"

    # If prefs.js exists, we need to remove conflicting preferences
    if [[ -f "$prefs_file" ]]; then
        info "Removing conflicting preferences from prefs.js..."

        # Create backup
        cp "$prefs_file" "$prefs_file.backup.$(date +%s)"

        # Extract preference names from user.js and remove them from prefs.js
        local temp_prefs=$(mktemp)
        cp "$prefs_file" "$temp_prefs"

        while IFS= read -r line; do
            # Skip empty lines and comments
            if [[ -z "$line" || "$line" =~ ^[[:space:]]*// ]]; then
                continue
            fi

            # Extract preference name from user_pref("pref.name", value);
            if [[ "$line" =~ user_pref\(\"([^\"]+)\" ]]; then
                pref_name="${BASH_REMATCH[1]}"
                # Remove this preference from prefs.js so user.js takes precedence
                sed -i "/user_pref(\"$(printf '%s\n' "$pref_name" | sed 's/[[\.*^$()+?{|]/\\&/g')\",/d" "$temp_prefs"
            fi
        done <"$userjs_file"

        # Write back the cleaned prefs.js
        mv "$temp_prefs" "$prefs_file"
        ok "Cleaned conflicting preferences from prefs.js"
    fi

    # Remove compatibility.ini to force Firefox to re-read user.js
    if [[ -f "$profile_dir/compatibility.ini" ]]; then
        rm "$profile_dir/compatibility.ini"
        info "Removed compatibility.ini to force preference reload"
    fi

    # Remove times.json to reset profile timestamp
    if [[ -f "$profile_dir/times.json" ]]; then
        rm "$profile_dir/times.json"
        info "Reset profile timestamp"
    fi
}

# Check if Floorp is running
check_floorp_running() {
    if pgrep -x "floorp" >/dev/null; then
        error "Floorp is currently running!"
        echo "Please close Floorp completely before running this script."
        echo "user.js preferences are only read on browser startup."
        exit 1
    fi
}

# Validate user.js syntax
validate_userjs() {
    local userjs_file="$SCRIPT_DIR/user.js"

    info "Validating user.js syntax..."

    # Check for common syntax errors
    local line_num=0
    while IFS= read -r line; do
        ((line_num++))

        # Skip empty lines and comments
        if [[ -z "$line" || "$line" =~ ^[[:space:]]*// ]]; then
            continue
        fi

        # Check for user_pref lines
        if [[ "$line" =~ user_pref\( ]]; then
            # Check for missing semicolon
            if [[ ! "$line" =~ \;[[:space:]]*$ ]]; then
                error "Missing semicolon on line $line_num: $line"
                return 1
            fi

            # Check for basic syntax
            if [[ ! "$line" =~ ^[[:space:]]*user_pref\(\"[^\"]+\",[[:space:]]*.*\)\;[[:space:]]*$ ]]; then
                warn "Potentially malformed preference on line $line_num: $line"
            fi
        fi
    done <"$userjs_file"

    ok "user.js validation completed"
}

# Find Floorp profile directory
find_floorp_profile() {
    local FLOORP_DIRS=("$HOME/.floorp" "$HOME/.mozilla/floorp" "$HOME/snap/floorp/common/.floorp" "$HOME/.var/app/one.ablaze.floorp/.floorp")
    local FLOORP_PROFILES_DIR=""

    for dir in "${FLOORP_DIRS[@]}"; do
        if [[ -d "$dir" ]]; then
            FLOORP_PROFILES_DIR="$dir"
            break
        fi
    done

    # Create if not found
    if [[ -z "$FLOORP_PROFILES_DIR" ]]; then
        FLOORP_PROFILES_DIR="$HOME/.floorp"
        mkdir -p "$FLOORP_PROFILES_DIR"
        info "Created Floorp profiles directory: $FLOORP_PROFILES_DIR"
    fi

    # Find or create profile
    local PROFILE_DIR=""
    if [[ -f "$FLOORP_PROFILES_DIR/profiles.ini" ]]; then
        while IFS= read -r line; do
            if [[ $line == Path=* ]]; then
                profile_path="${line#Path=}"
                if [[ -d "$FLOORP_PROFILES_DIR/$profile_path" ]]; then
                    PROFILE_DIR="$FLOORP_PROFILES_DIR/$profile_path"
                    break
                fi
            fi
        done <"$FLOORP_PROFILES_DIR/profiles.ini"
    fi

    # Look for existing profile if profiles.ini didn't work
    if [[ -z "$PROFILE_DIR" ]]; then
        for dir in "$FLOORP_PROFILES_DIR"/*; do
            if [[ -d "$dir" && (-f "$dir/prefs.js" || -f "$dir/user.js") ]]; then
                PROFILE_DIR="$dir"
                break
            fi
        done
    fi

    # Create new profile if none found
    if [[ -z "$PROFILE_DIR" ]]; then
        PROFILE_DIRNAME="$(date +%s).elena"
        PROFILE_DIR="$FLOORP_PROFILES_DIR/$PROFILE_DIRNAME"
        mkdir -p "$PROFILE_DIR"

        cat >"$FLOORP_PROFILES_DIR/profiles.ini" <<EOF
[General]
StartWithLastProfile=1
Version=2

[Profile0]
Name=elena
IsRelative=1
Path=$PROFILE_DIRNAME
Default=1
EOF
        info "Created new profile: $PROFILE_DIRNAME"
    fi

    echo "$PROFILE_DIR"
}

# Main execution
main() {
    info "Starting Floorp configuration setup..."

    # Check if Floorp is running
    check_floorp_running

    # Validate user.js
    validate_userjs

    # Find profile directory
    PROFILE_DIR=$(find_floorp_profile)
    info "Using profile: $(basename "$PROFILE_DIR")"

    # Apply user.js preferences
    apply_userjs_preferences "$PROFILE_DIR"

    # Install other files
    info "Installing additional configuration files..."

    # Search configuration
    if [[ -f "$PROFILE_DIR/search.json.mozlz4" ]]; then
        cp "$PROFILE_DIR/search.json.mozlz4" "$PROFILE_DIR/search.json.mozlz4.backup.$(date +%s)"
    fi
    cp "$SCRIPT_DIR/search.json.mozlz4" "$PROFILE_DIR/"
    ok "Installed search configuration"

    # MIME associations
    mkdir -p "$HOME/.config"
    if [[ -f "$HOME/.config/mimeapps.list" ]]; then
        cp "$HOME/.config/mimeapps.list" "$HOME/.config/mimeapps.list.backup.$(date +%s)"
    fi
    cp "$SCRIPT_DIR/mimeapps.list" "$HOME/.config/"
    ok "Installed MIME associations"

    # Create wallpapers directory
    mkdir -p "$HOME/Pictures/wallpapers"
    ok "Created wallpapers directory"

    # Success message
    echo
    ok "✓ Configuration applied successfully!"
    ok "✓ Profile: $(basename "$PROFILE_DIR")"
    echo
    warn "Manual steps required:"
    echo "1. Install system policies:"
    echo "   sudo mkdir -p /etc/floorp/policies"
    echo "   sudo cp '$SCRIPT_DIR/policies.json' /etc/floorp/policies/policies.json"
    echo
    echo "2. Place your browser background image at:"
    echo "   ~/Pictures/wallpapers/browser.jpg"
    echo
    echo "3. Start Floorp - your preferences will be applied!"
    echo
    info "Note: user.js preferences override any conflicting settings and are applied on every startup."
}

# Run main function
main "$@"
