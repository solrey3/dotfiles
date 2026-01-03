# just is a command runner, Justfile is very similar to Makefile, but simpler.

armHostname := "delta"
intelHostname := "charlie"

############################################################################
#
#  Darwin related commands
#
############################################################################

#  Remove this target if a proxy is not required during builds
darwin-set-proxy:
  sudo python3 scripts/darwin_set_proxy.py

# darwin: darwin-set-proxy
darwin-delta:
  nix build .#darwinConfigurations.delta.system \
    --extra-experimental-features 'nix-command flakes' --impure
  sudo ./result/sw/bin/darwin-rebuild switch --flake .#delta --impure
# darwin-debug: darwin-set-proxy
darwin-delta-debug:
  nix build .#darwinConfigurations.delta.system --show-trace --verbose \
    --extra-experimental-features 'nix-command flakes' --impure
  sudo ./result/sw/bin/darwin-rebuild switch --flake .#delta --show-trace --verbose --impure

# darwin: darwin-set-proxy
darwin-foxtrot:
  nix build .#darwinConfigurations.foxtrot.system \
    --extra-experimental-features 'nix-command flakes' --impure
  ./result/sw/bin/darwin-rebuild switch --flake .#foxtrot --impure
# darwin-debug: darwin-set-proxy
darwin-foxtrot-debug:
  nix build .#darwinConfigurations.foxtrot.system --show-trace --verbose \
    --extra-experimental-features 'nix-command flakes'
  ./result/sw/bin/darwin-rebuild switch --flake .#foxtrot --show-trace --verbose

# darwin: darwin-set-proxy
darwin-juliet:
  nix build .#darwinConfigurations.juliet.system \
    --extra-experimental-features 'nix-command flakes' --impure \
    --option substitute true
  sudo ./result/sw/bin/darwin-rebuild switch --flake .#juliet --impure
# darwin-debug: darwin-set-proxy
darwin-juliet-debug:
  nix build .#darwinConfigurations.juliet.system --show-trace --verbose \
    --extra-experimental-features 'nix-command flakes' --impure
  sudo ./result/sw/bin/darwin-rebuild switch --flake .#juliet --show-trace --verbose --impure

nixos-alpha:
  sudo nixos-rebuild switch --flake .#alpha --impure
nixos-alpha-debug:
  sudo nixos-rebuild switch --flake .#alpha --impure --show-trace

nixos-bravo:
  sudo nixos-rebuild switch --flake .#bravo --impure
nixos-bravo-debug:
  sudo nixos-rebuild switch --flake .#bravo --impure --show-trace

nixos-charlie:
  sudo nixos-rebuild switch --flake .#charlie --impure
nixos-charlie-debug:
  sudo nixos-rebuild switch --flake .#charlie --impure --show-trace

nixos-golf:
  sudo nixos-rebuild switch --flake .#golf --impure
nixos-golf-debug:
  sudo nixos-rebuild switch --flake .#golf --impure --show-trace

nixos-kilo:
  sudo nixos-rebuild switch --flake .#kilo --impure
nixos-kilo-debug:
  sudo nixos-rebuild switch --flake .#kilo --impure --show-trace

nixos-mike:
  sudo nixos-rebuild switch --flake .#mike --impure
nixos-mike-debug:
  sudo nixos-rebuild switch --flake .#mike --impure --show-trace

nixos-november:
  sudo nixos-rebuild switch --flake .#november --impure
nixos-november-debug:
  sudo nixos-rebuild switch --flake .#november --impure --show-trace

nixos-oscar:
  sudo nixos-rebuild switch --flake .#oscar --impure
nixos-oscar-debug:
  sudo nixos-rebuild switch --flake .#oscar --impure --show-trace

nixos-papa:
  sudo nixos-rebuild switch --flake .#papa --impure
nixos-papa-debug:
  sudo nixos-rebuild switch --flake .#papa --impure --show-trace

home-echo:
  home-manager switch --flake .#echo

home-india:
  home-manager switch --flake .#india

############################################################################
#
#  nix related commands
#
############################################################################


update:
  nix flake update

update-lock:
  nix flake update
  git add flake.lock
  git commit -m "chore: update flake.lock"

history:
  nix profile history --profile /nix/var/nix/profiles/system

gc:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

  # garbage collect all unused nix store entries
  sudo nix store gc --debug


fmt:
  # format the nix files in this repo
  nix fmt

clean:
  rm -rf result
