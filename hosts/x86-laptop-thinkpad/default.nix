{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "laptop-x86-thinkpad"; # Define your hostname.
}
