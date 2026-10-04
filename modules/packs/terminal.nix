{
  inputs,
  ...
}:
{
  flake.modules.nixos.terminal = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.terminal
    ];
  };

  flake.modules.homeManager.terminal = {pkgs, ...}: {
    home.packages = [
      pkgs.alacritty
    ];
  };
}    
