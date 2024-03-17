# Nix config for all my machines

To run on NixOS

```bash
sudo nixos-rebuild switch --flake /home/bharadwaj/nixos-config#default --show-trace
```

If eval cache error comes during changes, disable it

```bash
sudo nixos-rebuild switch --flake /home/bharadwaj/nixos-config#default --option eval-cache false --show-trace
```
