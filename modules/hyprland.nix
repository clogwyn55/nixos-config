{ pkgs, ... }:

let
  hyprland-environment = pkgs.writeTextFile {
  name = "hyprland-environment";
  destination = "/bin/hyprland-environment";
  executable = true;

  text = ''
    dbus-update-activation-environment XDG_CURRENT_DESKTOP=sway
    systemctl --user stop xdg-desktop-portal-wlr xdg-desktop-portal-hyprland
    systemctl --user start xdg-desktop-portal-wlr xdg-desktop-portal-hyprland
  '';
  };
in
{
  programs = {
    blueman.enable = true; #blutooth manager
    hyprland.enable = true;
    hyprland.xwayland.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  services = {
    gvfs.enable = true; # thunar mount, trash, and other functionalityy
    tumbler.enable = true; # thunar thumbnail support for images
  };

  networkmanager.unmanaged = [ "type:wifi" ]; # I believe this cases errors if not included
  
  security.pam.services.swaylock = {}; #allows swaylock to be unlocked

  environment = {
    sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway"; #for firefox
    };
    systemPackages = with pkgs; [
      foot #backup
      gnome-text-editor #backup
      grim
      hyprland-environment
      pavucontrol
      slurp
      spotify-tui
      swaylock-effects
      hyprpaper
      wayland
    ];
  };

  xdg.portal = {
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
