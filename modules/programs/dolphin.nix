{
  inputs,
  ...
}:
{
  flake.modules.nixos.dolphin = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.dolphin
    ];
  };

  flake.modules.homeManager.dolphin = {pkgs, ...}: {
    home.packages = [
      pkgs.kdePackages.dolphin
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.ark
    ];
  };
}    
