{
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  #users.users.aaron.openssh.authorizedKeys.keys = 
  #  [ "ssh-dss !!!!!" ];
  };
}
