{
  home-manager.users.aaron = {

    imports = [
      ./programs/git
      ./programs/nvim
      ./programs/shell
    ];

    home = {
      username = "aaron";
      homeDirectory = "/home/aaron";
      stateVersion = "23.11";
    };

      programs.home-manager.enable = true;
  };
}
