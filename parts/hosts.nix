{ withSystem, inputs, outputs, ... }:
{
  flake = { config, ... }:
  let
    inherit (inputs) nixpkgs unstable;
    # Stupid question: we are in the output section of the flake 
    inherit (outputs) lib;
  in {
    nixosConfigurations = {}
  };
}
