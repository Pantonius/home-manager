{ ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "anton";
  home.homeDirectory = "/home/anton";

  services.gnome-keyring.enable = true;

  # Shells
  # Some modules of my own
  ## Zsh
  zsh.enable = true;

  ## Zoxide
  zoxide.enable = true;

  ## fzf (fuzzyfind)
  fzf.enable = true;

  ## Terminal
  ghostty.enable = true;

  ## Neovim Config
  nixvim.enable = true;

  ## VSCodium
  vscodium.enable = true;

  ## Git
  git.enable = true;

  ## Neofetch but different
  bmofetch.enable = true;

  ## Tmux
  tmux.enable = true;

  ## Notification Manager Config
  dunst.enable = true;
  # swaync.enable = true;
  # gtkTheme.enable = true;

  ## Hyprland Config
  hyprland.enable = true;
  hyprlock.enable = true;
  hyprcursor.enable = true;
  # hyprgrass.enable = true;
  hyprpaper.enable = true;
  hyprsunset.enable = true;

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

  ## Utils
  nh.enable = true;

  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
