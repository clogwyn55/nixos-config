{ pkgs, ... }:
{
  imports = [
    ./programs/dunst
    ./programs/hyprland
    ./programs/rofi
    ./programs/spotify-tui
    ./programs/swayidle
    ./programs/swaylock-effects
    ./programs/waybar
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
