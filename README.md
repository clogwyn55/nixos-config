# nixos-config

Not all modules have been thoroughly tested with each other. Notably the HTPC modules are currently not functional.

Apply configs from base folder with

```
sudo nixos-rebuild switch --flake .#<machine-name>
```

Available machine names are in the hosts folder.
