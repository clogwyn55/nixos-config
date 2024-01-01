{
  programs.mpv = {
    enable = true;
    defaultProfiles = ["gpu-hq"];
    config = {
      loop-file="inf";
    };
    #scripts = [ pkgs.mpvScripts.mpris ];
  };
}
