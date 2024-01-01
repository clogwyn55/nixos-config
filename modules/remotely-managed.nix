{
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      #PasswordAuthentication = false; #need to do some work for this
    };
    openFirewall = true;
  #users.users.aaron.openssh.authorizedKeys.keys = 
  #  [ "ssh-dss !!!!!" ];
  };
}
