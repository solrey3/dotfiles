# India

Steam Deck running SteamOS 3.0. Hardware: 8 × AMD Custom APU 0932, 14.5 GiB RAM, and AMD Custom GPU 0932 (Valve Galileo, System Version 1). Apply with `just home-india`.

## Installing Nix

Install the multi-user version of Nix using the official script:

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Enable flakes by adding the following to `~/.config/nix/nix.conf`:

```sh
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

## Installing Just

Install the `just` command runner from Nixpkgs:

```sh
nix profile install nixpkgs#just
```

With Nix and just installed, run the following to apply this home-manager configuration:

```sh
just home-india
```
