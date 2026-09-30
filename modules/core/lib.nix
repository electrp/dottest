{ self, inputs, lib, ... }:
let 
  # Define library functions
  clib = {
    mkNixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}
          { nixpkgs.hostPlatform = lib.mkDefault system; }
        ];
        specialArgs = {
          pkgs-main = import inputs.main {
              system = system;
              config.allowUnfree = true;
          };
        };
      };
    };

    mkDarwin = system: name: {
      ${name} = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          inputs.self.modules.darwin.${name}
          { nixpkgs.hostPlatform = lib.mkDefault system; }
        ];
      };
    };

    # mkHomeManager = system: name: {
    #   ${name} = inputs.home-manager.lib.homeManagerConfiguration {
    #     pkgs = inputs.nixpkgs.legacyPackages.${system};
    #     modules = [
    #       inputs.self.modules.homeManager.${name}
    #       { nixpkgs.config.allowUnfree = true; }
    #     ];
    #   };
    # };
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
