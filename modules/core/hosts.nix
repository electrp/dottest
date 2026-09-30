{ withSystem, inputs, self, ... }:
{
  # flake = { config, ... }:
  # let
  #   inherit (inputs) nixpkgs unstable;
  #   inherit (self) outputs;
  #   # Stupid question: we are in the output section of the flake 
  #   inherit (outputs) lib machineConfs;
  #   # machineConfs is all the configurations as data in an array


  # in {
  #   apps = {};
  #   nixosConfigurations.test = inputs.nixpkgs.lib.nixosSystem {
  #     system = "x86_64-linux";
  #     modules = [

  #     ];
  #   };
  # };
}
# nix flake check --all-systems
# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/wiki/Dendritic_Aspects#inheritence-aspect