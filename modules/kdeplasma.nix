{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "aaron";
      sddm.enable = true;
      #defaultSession = "plasmawayland";
    };
    desktopManager.plasma5.enable = true;
  };

  # undesired programs
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    konsole
  ];


  environment.systemPackages = with pkgs; [
    gnupg
    isoimagewriter
    kate
    libsForQt5.kalarm
  ];
}
