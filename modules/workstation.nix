{ pkgs, ... }:
{

  hardware.opengl = {
    extraPackages = with pkgs; [ mangohud rocmPackages.clr.icd ];
    extraPackages32 = with pkgs; [ mangohud ];
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  users.users.aaron.extraGroups = [ "libvirtd" ];

  virtualisation.libvirtd.enable = true;

  programs = {
    virt-manager.enable = true;
    gnupg.agent = { #gpg keys
      enable = true;
      pinentryFlavor = "gtk2";
      enableSSHSupport = true;
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  
  services = {
    blueman.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };
    pcscd.enable = true; #needed for gpg keys
    flatpak = {
      enable = true;
      packages = [ "com.discordapp.Discord" ];
      update.auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };

  fonts.packages = [
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  environment = {
    sessionVariables = {
      MANGOHUD_CONFIGFILE=/home/aaron/.config/MangoHud;
    };
    systemPackages = with pkgs; [
      anki
      betterdiscordctl
      blender-hip
      calibre
      firefox
      godot_4
      jellyfin-media-player
      pinentry-gtk2 #for gpg keys
      system76-keyboard-configurator 
      tor-browser
      virtiofsd #for sharing folders w/ a virtual machine
      wezterm
      wl-clipboard
    ];
  };
}
