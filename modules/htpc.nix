{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  users.extraUsers.kodi.isNormalUser = true;

  services.cage = { 
    enable = true;
    user = "kodi";
    program = "${pkgs.kodi-wayland.passthru.withPackages (kodiPkgs: with kodiPkgs; [ 
      invidious
      jellyfin
      steam-launcher
      steam-controller
    ])}/bin/kodi-standalone";
  };
}
