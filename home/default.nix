{

  imports = [
    ./git
    ./nvim
    ./shell
  ];

  home = {
    username = "aaron";
    homeDirectory = "/home/aaron";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
