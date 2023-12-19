{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "laptop-x86-s76";
#      interface.eth0.ipv4.addresses = [ {
#        address = "10.0.0.2";
#        prefixLength = 24;
#      } ];
  };
}
