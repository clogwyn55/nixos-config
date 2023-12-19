laptop-x86-s76-build:
	nixos-rebuild switch --flake .#laptop-x86-s76 --use-remote-sudo
laptop-x86-s76-iso:
	nix build .#nixosConfigurations.laptop-x86-thinkpad.config.system.build.isoImage --use-remote-sudo
laptop-x86-thinkpad:
	nixos-rebuild switch --flake .#laptop-x86-thinkpad --use-remote-sudo
ftower-x86-gaming:
	nixos-rebuild switch --flake .#ftower-x86-gaming --use-remote-sudo
smllff-x86-bedhtpc:
	nixos-rebuild switch --flake .#smllff-x86-bedhtpc --use-remote-sudo
smllff-x86-livhtpc:
	nixos-rebuild switch --flake .#smllff-x86-livhtcp --use-remote-sudo
server-x86-media:
	nixos-rebuild switch --flake .#server-x86-media --use-remote-sudo
server-rpi-rproxy:
	nixos-rebuild switch --flake .#server-rpi-rproxy --use-remote-sudo
