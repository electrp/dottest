{
  inputs,
  config,
  ...
}:
let
  home-manager-config =
    { lib, pkgs-main, ... }:
    {
      home-manager = {
        verbose = true;
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "backup";
        backupCommand = "rm";
        overwriteBackup = true;
        extraSpecialArgs = { 
          pkgs-master = import inputs.main {
            system = "x86_64-linux";
            config.allowUnfree = true;
          }; 
        };
      };
    };
in
{
  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      home-manager-config
    ];
  };

  flake.modules.darwin.home-manager = {
    imports = [
      inputs.home-manager.darwinModules.home-manager
      home-manager-config
    ];
  };

}