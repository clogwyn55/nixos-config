{ pkgs, ... }: {

  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };


  services = {
    ratbagd.enable = true;
    flatpak = {
      enable = true;
      packages = [
        "com.valvesoftware.Steam"
      ];
      update.auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
  
  environment.systemPackages = with pkgs; [
    obs-studio
    piper
	xivlauncher
    gamemode
    gamescope
  ];
}
