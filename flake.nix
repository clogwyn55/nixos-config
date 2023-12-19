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
            home-manager.users.aaron = {
              imports = extraHomeModules;
            };
          }
        ] ++ extraModules; #system modules
      };
    in
    {
      nixosConfigurations = {
        x86-laptop-galago = mkComputer
          ./hosts/x86-laptop-galago #machine specific configuration
          [ #system-wide modules
            ./modules/systemdboot.nix
            ./modules/pipewire.nix
            ./modules/laptop.nix
            ./modules/common.nix
            ./modules/workstation.nix
            ./modules/hyprland.nix
            ./modules/gtk.nix
            nix-flatpak.nixosModules.nix-flatpak
          ] 
          [ #user-specific modules
            ./home
            ./home/workstation
            ./home/workstation/hyprland-apps
          ]; #modules to be loaded by home-manager
        x86-laptop-thinkpad = mkComputer
          ./hosts/x86-laptop-thinkpad #machine specific configuration
          [ #system-wide modules
            ./modules/grub.nix
            ./modules/pipewire.nix
            ./modules/laptop.nix
            ./modules/common.nix
            ./modules/workstation.nix
            ./modules/hyprland.nix
            ./modules/gtk.nix
            nix-flatpak.nixosModules.nix-flatpak
          ] 
          [ #user-specific modules
            ./home
            ./home/workstation
            ./home/workstation/hyprland-apps
          ]; #modules to be loaded by home-manager
        x86-atxtwr-gaming = mkComputer
          ./hosts/x86-atxtwr-gaming
          [
            nix-flatpak.nixosModules.nix-flatpak
            ./modules/systemdboot.nix
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
            ./home/workstation/kde-apps
          ];
        x86-merkat-bedhtpc = mkComputer
          ./hosts/smllff-x86-bedhtpc
          [
            ./modules/systemdboot.nix
            ./modules/pipewire.nix
            ./modules/common.nix
            ./modules/remotely-managed.nix
            ./modules/htpc.nix
          ]
          [
            ./home
            ./home/htpc
          ];
        server-x86-media = mkComputer
          ./modules/server-x86-media
          [
            ./modules/systemdboot.nix
            ./modules/nvidia.nix
            ./modules/common.nix
            ./modules/remotely-managed.nix
          ]
          [
            ./home
          ];
      };
    };
}
