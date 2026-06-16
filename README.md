# dottest
test

vm: `nixos-rebuild --flake .#stupid build-vm`
test: `nix flake check --all-systems`