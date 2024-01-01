{
  description = "aaron's nixos system configuration flake";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org" #cache servers speeds up build time
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.2.0";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, sops-nix, nix-flatpak, ... }:
    let
      system = "x86_64-linux";
      mkComputer = configurationNix: extraModules: extraHomeModules: inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit system inputs; };
        modules = [
          sops-nix.nixosModules.sops
          configurationNix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            imports = extraHomeModules;
          }
        ] ++ extraModules; #system modules
      };
    in
    {
      nixosConfigurations = {
        x86-laptop-galago = mkComputer
          ./hosts/x86-laptop-galago #machine specific configuration
          [ #system-wide modules
            nix-flatpak.nixosModules.nix-flatpak
            ./modules/systemdboot.nix
            ./modules/pipewire.nix
            ./modules/bluetooth.nix
            ./modules/laptop.nix
            ./modules/common.nix
            ./modules/workstation.nix
            ./modules/hyprland.nix
            ./modules/gtk.nix
          ] 
          [ #user-specific modules
            ./home
            ./home/workstation
            ./home/workstation/hyprland
          ];
        x86-laptop-thinkpad = mkComputer
          ./hosts/x86-laptop-thinkpad #machine specific configuration
          [ #system-wide modules
            nix-flatpak.nixosModules.nix-flatpak
            ./modules/grub.nix
            ./modules/pipewire.nix
            ./modules/bluetooth.nix
            ./modules/laptop.nix
            ./modules/common.nix
            ./modules/workstation.nix
            ./modules/hyprland.nix
            ./modules/gtk.nix
          ] 
          [ #user-specific modules
            ./home
            ./home/workstation
            ./home/workstation/hyprland
          ];
        x86-atxtwr-gaming = mkComputer
          ./hosts/x86-atxtwr-gaming
          [
            nix-flatpak.nixosModules.nix-flatpak
            ./modules/systemdboot.nix
            ./modules/amdgpu.nix
            ./modules/pipewire.nix
            ./modules/bluetooth.nix
            ./modules/common.nix
            ./modules/workstation.nix
            ./modules/kdeplasma.nix
            ./modules/gaming.nix
          ]
          [
            ./home
            ./home/workstation
            ./home/workstation/plasma
          ];
        x86-merkat-bedhtpc = mkComputer
          ./hosts/x86-merkat-bedhtpc
          [
            ./modules/systemdboot.nix
            ./modules/pipewire.nix
            ./modules/bluetooth.nix
            ./modules/intel.nix
            ./modules/common.nix
            ./modules/remotely-managed.nix
            ./modules/htpc.nix
          ]
          [
            ./home
            ./home/htpc
          ];
        x86-merkat-livhtpc = mkComputer
          ./hosts/x86-merkat-livhtpc
          [
            ./modules/systemdboot.nix
            ./modules/pipewire.nix
            ./modules/bluetooth.nix
            ./modules/intel.nix
            ./modules/common.nix
            ./modules/remotely-managed.nix
            ./modules/htpc.nix
          ]
          [
            ./home
            ./home/htpc
          ];
        x86-server-media = mkComputer
          ./modules/x86-server-media
          [
            ./modules/systemdboot.nix
            ./modules/nvidia.nix
            ./modules/common.nix
            ./modules/remotely-managed.nix
          ]
          [
            ./home
          ];
        x86-vrtual-test = mkComputer
          ./hosts/x86-vrtual-test
          [
            ./modules/grub.nix
            ./modules/amdgpu.nix
            ./modules/pipewire.nix
            ./modules/common.nix
            ./modules/workstation.nix
            ./modules/kdeplasma.nix
            ./modules/gaming.nix
          ]
          [
            ./home
            ./home/workstation
            ./home/workstation/plasma
          ];
      };
    };
}
