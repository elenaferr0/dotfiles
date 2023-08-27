echo "nvim"
cp $HOME/.config/nvim/init.lua ./nvim/init.lua
cp $HOME/.config/nvim/lua/plugins.lua ./nvim/lua/plugins.lua
echo "wofi"
cp -r $HOME/.config/wofi/ .
echo "waybar"
cp -r $HOME/.config/waybar/ .
echo "hyprland"
cp -r $HOME/.config/hypr/ .
echo "alacritty"
cp -r $HOME/.config/alacritty/ .
echo "zsh"
cp $HOME/.zshrc .
echo "starship theme"
cp ~/.config/starship.toml .
echo "zathura"
cp -r $HOME/.config/zathura/ .
echo "gtklock"
cp -r $HOME/.config/gtklock .
