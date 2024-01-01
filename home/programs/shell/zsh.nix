{
  programs.zsh = {
    enable = true;
    autocd = true;
    defaultKeymap = "viins";
    dirHashes = {
      docs = "$HOME/documents";
      pics = "$HOME/pictures";
      vids = "$HOME/videos";
      dls = "$HOME/downloads";
      repos = "$HOME/repos";
    };
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    history = {
      ignoreAllDups = true;
      extended = true;
      path="$XDG_CONFIG_HOME/zsh/zsh_history";
    };
    #localVariables = {
    #  THEME = [ "dracula" ];
    #};
    initExtra = ''
      freshfetch
      bindkey "^O" vi-cmd-mode
      bindkey "^H" vi-backward-char
      bindkey "^L" vi-forward-char
    '';
    shellAliases = {
      diff = "diff --color";
      work = "cd /home/aaron/repos";
      la = "ls -lah";
      vim = "nvim";
    };
  };
}
