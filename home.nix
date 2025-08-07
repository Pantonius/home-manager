{ ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "anton";
  home.homeDirectory = "/home/anton";

  services.gnome-keyring.enable = true;

  # Shells
  programs.bash.enable = true;

  # Some modules of my own
  ## Terminal
  alacritty.enable = true;

  ## Git
  git.enable = true;

  ## Neofetch but different
  bmofetch.enable = true;

  ## Notification Manager Config
  dunst.enable = true;
  # gtkTheme.enable = true;

  ## Hyprland Config
  hyprland.enable = true;
  hyprlock.enable = true;
  hyprcursor.enable = true;
  # hyprgrass.enable = true;
  hyprpaper.enable = true;
  hyprsunset.enable = true;

  ## Neovim Config
  nixvim.enable = true;

  ## Pretty Proto Config
  pretty-proto.enable = true;

  ## Rofi Config
  rofi.enable = true;

  ## Style Config
  # stylix-theme.enable = true;
  waybar.enable = true;
  # hyprpanel.enable = true;

  ## Zathura
  zathura.enable = true;

  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
