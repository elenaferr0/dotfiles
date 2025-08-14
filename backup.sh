#!/bin/bash
# sync-dotfiles.sh - Sync dotfiles to/from repository

set -euo pipefail

# Configuration
REPO_DIR="$(pwd)"
LOG_FILE="$REPO_DIR/sync.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Backup/Push function - sync FROM home TO repo
backup_config() {
    local name="$1"
    local source="$2"
    local dest="$3"
    
    print_status "Syncing $name to repo..."
    
    if [[ ! -e "$source" ]]; then
        print_warning "$name not found at $source - skipping"
        log "SKIPPED: $name - source not found: $source"
        return 0
    fi
    
    # Create destination directory if needed
    local dest_dir
    dest_dir="$(dirname "$REPO_DIR/$dest")"
    mkdir -p "$dest_dir"
    
    if cp -r "$source" "$REPO_DIR/$dest" 2>/dev/null; then
        print_success "$name synced to repo successfully"
        log "SUCCESS: $name - $source -> $REPO_DIR/$dest"
    else
        print_error "Failed to sync $name to repo"
        log "ERROR: $name - failed to copy $source to $REPO_DIR/$dest"
        return 1
    fi
}

# Restore/Pull function - sync FROM repo TO home
restore_config() {
    local name="$1"
    local source="$2"
    local dest="$3"
    
    print_status "Syncing $name from repo..."
    
    if [[ ! -e "$source" ]]; then
        print_warning "$name not found in repo at $source - skipping"
        log "SKIPPED: $name - source not found: $source"
        return 0
    fi
    
    # Create destination directory if needed
    local dest_dir
    dest_dir="$(dirname "$dest")"
    mkdir -p "$dest_dir"
    
    if cp -r "$source" "$dest" 2>/dev/null; then
        print_success "$name synced from repo successfully"
        log "SUCCESS: $name - $source -> $dest"
    else
        print_error "Failed to sync $name from repo"
        log "ERROR: $name - failed to copy $source to $dest"
        return 1
    fi
}

# Push dotfiles to repository
push_dotfiles() {
    print_status "Pushing dotfiles to repository..."
    log "=== Push to Repository Started ==="
    log "Repository directory: $REPO_DIR"
    log "Home directory: $HOME"
    
    local failed_count=0
    
    # Create necessary directories
    mkdir -p "$REPO_DIR/nvim/lua"
    
    # Define configurations to sync
    declare -A configs=(
        ["Waybar"]="$HOME/.config/waybar:waybar"
        ["Neovim init"]="$HOME/.config/nvim/init.lua:nvim/init.lua"
        ["Neovim plugins"]="$HOME/.config/nvim/lua/plugins.lua:nvim/lua/plugins.lua"
        ["Wofi"]="$HOME/.config/wofi:wofi"
        ["Dunst"]="$HOME/.config/dunst:dunst"
        ["Hyprland"]="$HOME/.config/hypr:hypr"
        ["Alacritty"]="$HOME/.config/alacritty:alacritty"
        ["Zsh config"]="$HOME/.zshrc:.zshrc"
        ["Powerlevel10k"]="$HOME/.p10k.zsh:.p10k.zsh"
        ["Starship"]="$HOME/.config/starship.toml:starship.toml"
        ["Zathura"]="$HOME/.config/zathura:zathura"
        ["Wpaperd"]="$HOME/.config/wpaperd:wpaperd"
    )
    
    # Sync each configuration
    for name in "${!configs[@]}"; do
        IFS=':' read -r source_path dest_path <<< "${configs[$name]}"
        
        if ! backup_config "$name" "$source_path" "$dest_path"; then
            ((failed_count++))
        fi
    done
    
    # Update repository info
    cat > "$REPO_DIR/repo-info.md" << EOF
# Dotfiles Repository

Last Updated: $(date)
Hostname: $(hostname)
User: $(whoami)
Home Directory: $HOME

## Configurations Included:

- **Waybar**: Status bar configuration
- **Neovim**: Editor configuration and plugins
- **Wofi**: Application launcher
- **Dunst**: Notification daemon
- **Hyprland**: Window manager
- **Alacritty**: Terminal emulator
- **Zsh**: Shell configuration
- **Powerlevel10k**: Zsh theme
- **Starship**: Cross-shell prompt
- **Zathura**: PDF viewer
- **Wpaperd**: Wallpaper daemon

## Usage:

\`\`\`bash
# Push current configs to repo
./sync-dotfiles.sh push

# Pull configs from repo
./sync-dotfiles.sh pull

# Show status
./sync-dotfiles.sh status
\`\`\`
EOF
    
    log "=== Push completed with $failed_count failures ==="
    
    if [[ $failed_count -eq 0 ]]; then
        print_success "All configurations pushed to repository!"
    else
        print_warning "Push completed with $failed_count failures. Check $LOG_FILE for details."
    fi
    
    return $failed_count
}

# Pull dotfiles from repository
pull_dotfiles() {
    print_status "Pulling dotfiles from repository..."
    log "=== Pull from Repository Started ==="
    log "Repository directory: $REPO_DIR"
    log "Home directory: $HOME"
    
    local failed_count=0
    
    # Define restore mappings
    declare -A restore_configs=(
        ["Waybar"]"waybar:$HOME/.config/waybar"
        ["Neovim init"]"nvim/init.lua:$HOME/.config/nvim/init.lua"
        ["Neovim plugins"]"nvim/lua/plugins.lua:$HOME/.config/nvim/lua/plugins.lua"
        ["Wofi"]"wofi:$HOME/.config/wofi"
        ["Dunst"]"dunst:$HOME/.config/dunst"
        ["Hyprland"]"hypr:$HOME/.config/hypr"
        ["Alacritty"]"alacritty:$HOME/.config/alacritty"
        ["Zsh config"]".zshrc:$HOME/.zshrc"
        ["Powerlevel10k"]".p10k.zsh:$HOME/.p10k.zsh"
        ["Starship"]"starship.toml:$HOME/.config/starship.toml"
        ["Zathura"]"zathura:$HOME/.config/zathura"
        ["Wpaperd"]"wpaperd:$HOME/.config/wpaperd"
    )
    
    # Restore each configuration
    for name in "${!restore_configs[@]}"; do
        IFS=':' read -r repo_path dest_path <<< "${restore_configs[$name]}"
        source="$REPO_DIR/$repo_path"
        
        if ! restore_config "$name" "$source" "$dest_path"; then
            ((failed_count++))
        fi
    done
    
    log "=== Pull completed with $failed_count failures ==="
    
    if [[ $failed_count -eq 0 ]]; then
        print_success "All configurations pulled from repository!"
    else
        print_warning "Pull completed with $failed_count failures. Check $LOG_FILE for details."
    fi
    
    print_status "You may need to reload your shell or restart applications to see changes."
    
    return $failed_count
}

# Show repository status
show_status() {
    print_status "Repository Status"
    echo "=================="
    echo "Repository: $REPO_DIR"
    echo "Last sync: $(stat -c %y "$LOG_FILE" 2>/dev/null || echo "Never")"
    echo ""
    
    print_status "Repository contents:"
    find "$REPO_DIR" -type f -name "*.toml" -o -name "*.lua" -o -name "*.conf" -o -name ".zshrc" -o -name ".p10k.zsh" | grep -v sync.log | sort
    
    echo ""
    print_status "Git status (if repository):"
    if [[ -d "$REPO_DIR/.git" ]]; then
        cd "$REPO_DIR"
        git status --porcelain || true
    else
        echo "Not a git repository"
    fi
}

# Git integration helper
git_push() {
    if [[ ! -d "$REPO_DIR/.git" ]]; then
        print_warning "Not a git repository. Initialize with: git init"
        return 1
    fi
    
    cd "$REPO_DIR"
    print_status "Adding files to git..."
    git add .
    
    local commit_msg="${1:-"Update dotfiles $(date '+%Y-%m-%d %H:%M:%S')"}"
    print_status "Committing changes..."
    git commit -m "$commit_msg" || print_warning "No changes to commit"
    
    print_status "Pushing to remote..."
    git push || print_warning "Failed to push. Check remote configuration."
}

# Show help
show_help() {
    cat << EOF
Dotfiles Repository Sync Script
===============================

USAGE:
  $0 <command> [options]

COMMANDS:
  push              Push current dotfiles to repository
  pull              Pull dotfiles from repository to home
  status            Show repository status
  git-push [msg]    Git add, commit, and push (optional commit message)
  help              Show this help

EXAMPLES:
  # Push current configs to repo
  $0 push
  
  # Pull configs from repo to home
  $0 pull
  
  # Show status
  $0 status
  
  # Push to git with custom message
  $0 git-push "Updated Hyprland config"

REPOSITORY STRUCTURE:
  ├── waybar/           # Waybar configuration
  ├── nvim/            
  │   ├── init.lua     # Neovim init
  │   └── lua/
  │       └── plugins.lua
  ├── wofi/            # Wofi launcher
  ├── dunst/           # Notification daemon
  ├── hypr/            # Hyprland WM
  ├── alacritty/       # Terminal
  ├── zathura/         # PDF viewer
  ├── wpaperd/         # Wallpaper daemon
  ├── .zshrc           # Zsh config
  ├── .p10k.zsh        # Powerlevel10k theme
  ├── starship.toml    # Starship prompt
  ├── repo-info.md     # Repository information
  └── sync.log         # Sync log

EOF
}

# Main script logic
main() {
    case "${1:-help}" in
        "push"|"backup")
            push_dotfiles
            ;;
        "pull"|"restore")
            pull_dotfiles
            ;;
        "status")
            show_status
            ;;
        "git-push")
            push_dotfiles && git_push "${2:-}"
            ;;
        "help"|"--help"|"-h")
            show_help
            ;;
        *)
            print_error "Unknown command: ${1:-}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
