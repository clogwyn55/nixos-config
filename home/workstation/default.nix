{
  home-manager.users.aaron = {
    imports = [
      ./programs/mangohud
      ./programs/mpv
      ./programs/wezterm
    ];

    dconf.settings = { #connects virt-manager to qemu
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };

    xdg = {
      enable = true;
      userDirs = {
        createDirectories = true;
	    desktop = "$HOME/desktop";
	    documents = "$HOME/documents";
	    download = "$HOME/downloads";
	    music = "$HOME/music";
	    pictures = "$HOME/pictures";
	    videos = "$HOME/videos";
      };
    };
    
    fonts.fontconfig.enable = true;
  };
}
