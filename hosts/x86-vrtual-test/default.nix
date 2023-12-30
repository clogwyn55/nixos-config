{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "x86-vrtual-test";
#      interface.eth0.ipv4.addresses = [ {
#        address = "10.0.0.2";
#        prefixLength = 24;
#      } ];
  };
}
