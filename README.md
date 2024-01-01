# nixos-config

Not all modules have been thoroughly tested with each other. The laptop and gaming modules
should work fine, the server modules are a WIP.

Apply configs from base folder with

```
sudo nixos-rebuild switch --flake .#<machine-name>
```

Available machine names are in the hosts folder.
