{ pkgs, ... }: {

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  services = {
    flatpak = {
      enable = true;
      packages = [
        "com.valvesoftware.Steam" #proprietary
        "dev.goats.xivlauncher" #official package
      ];
      update.auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
  
  environment.systemPackages = with pkgs; [
    obs-studio
    gamemode
    gamescope
  ];
}
