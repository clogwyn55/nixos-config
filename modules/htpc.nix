{ pkgs, ... }:
{
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  users.extraUsers.kodi.isNormalUser = true;

  services.cage = { 
    enable = true;
    user = "kodi";
    program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
  };
}
