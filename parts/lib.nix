{ self, inputs, ... }:
let 
  # Define library functions
  clib = {

  };
in {
  # Within the flake,
  flake = _:
    {
      # Add lib, which is an extension of inputs.nixpkgs.lib
      lib = inputs.nixpkgs.lib.extend (_: _: {
        inherit (inputs.home-manager.lib) hm;
        inherit clib; 
      });
    };
}