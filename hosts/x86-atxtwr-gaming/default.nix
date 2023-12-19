{
  imports = [
    ./hardware-configuration.nix
  ];

#  boot.kernelParams = [ #maybe not needed
#    "video=DP-1:2560x1440@240"
#    "video=DP-3:1920x1080@144"
#  ];

  networking = {
    hostName = "ftower-x86-gaming";
#      interface.eth0.ipv4.addresses = [ {
#        address = "10.0.0.2";
#        prefixLength = 24;
#      } ];
  };
}
