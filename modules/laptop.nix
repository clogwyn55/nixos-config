{ pkgs, ... }:

{
    services.hardware.bolt.enable = true; #run boltctl for thunderbolt
    environment.systemPackages = with pkgs; [
        brightnessctl #for backlight
    ];
}

