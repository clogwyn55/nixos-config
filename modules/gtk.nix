{ pkgs, ... }:

let
  dbus-environment = pkgs.writeTextFile {
    name = "dbus-environment";
    destination = "/bin/dbus-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY
      systemctl --user stop xdg-desktop-portal
      systemctl --user start xdg-desktop-portal
    '';
  };
  configure-dracula-gtk = pkgs.writeTextFile {
    name = "configure-dracula-gtk";
    destination = "/bin/configure-dracula-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    dbus-environment
    configure-dracula-gtk
    xdg-utils # for opening default programs when clicking links
    glib # gsettings
    gnome3.adwaita-icon-theme  # default gnome cursors
    dracula-theme
  ];

  services = {
    gnome.at-spi2-core.enable = true; # needed for theming?
    dbus.enable = true;
  };


  xdg.portal = {
    enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
