{ pkgs, lib, ... }: {
	#SELinux causes errors currently
    # Bootloader
    boot = {
        #kernelParams = [ "security=selinux" ]; 
        #kernelPatches = [ {
        #   name = "selinux-config";
        #   patch = null;
        #   extraConfig = 
        #       SECURITY_SELINUX y
        #       SECURITY_SELINUX_BOOTPARAM n
        #       SECURITY_SELINUX_DISABLE n
        #       SECURITY_SELINUX_DEVELOP y
        #       SECURITY_SELINUX_AVC_STATS y
        #       SECURITY_SELINUX_CHECKREQPROT_VALUE 0
        #       DEFAULT_SECURITY_SELINUX
        #       ;
        #} ];
    };

    networking = {
      networkmanager.enable = true;
      #useDHCP = false;
      stevenblack.enable = true;
      firewall.enable = true;
      #defaultGateway = "192.168.0.1";
      #nameservers = [ "10.0.2.0" ];
    };

    time.timeZone = "America/Denver";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_DK.UTF-8"; # for yuro time
    };

  users.users.aaron = {
    ignoreShellProgramCheck = true;
    createHome = true;
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" ];
    initialPassword = "password"; #change later
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      trusted-users = [ "aaron" ];
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true; #for garbage collection
    };
  };

  security.sudo.wheelNeedsPassword = false;
  services.getty.autologinUser = lib.mkDefault "aaron";
  #systemd.package = pkgs.systemd.override { withSelinux = true; };

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    autoUpgrade.rebootWindow.lower = "01:00";
    autoUpgrade.rebootWindow.upper = "05:00";
  };

  hardware.enableRedistributableFirmware = true; #dunno what this does

  system.stateVersion = "23.11";

  environment = {
    variables = {
      EDITOR = "nvim";
    };
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_BIN_HOME = "$HOME/.local/bin";
    };
    shells = with pkgs; [ zsh ]; #adds zsh to /etc/shells
    systemPackages = with pkgs; [
      btop
      cabextract
      curl
      freshfetch
      git
      neovim
      starship
      unzip
      wget
      zsh
    ];
  };
}
