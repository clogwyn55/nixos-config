{ pkgs, ... }:
{
  imports = [
    ./dunst
    ./hyprland
    ./rofi
    ./spotify-tui
    ./swayidle
    ./swaylock-effects
    ./waybar
  ];

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };
}
