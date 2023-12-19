{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  home.file."/.config/rofi" = {
    source = ./config;
    recursive = true;
  };
}
