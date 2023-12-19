{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      full = true;
      no_display = true;
      cpu_load_change = true;
    };
  };

  home.file."/.config/MangoHud" = {
    source = ./config;
    recursive = true;
  };
}
