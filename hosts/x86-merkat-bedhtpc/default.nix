{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "smllff-x86-bedhtpc";
#      interface.eth0.ipv4.addresses = [ {
#        address = "10.0.0.2";
#        prefixLength = 24;
#      } ];
  };
}
