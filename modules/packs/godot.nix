{
  inputs,
  ...
}:
{
  flake.modules.nixos.godot = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.godot
    ];
  };

  flake.modules.homeManager.godot = {pkgs, ...}: {
    home.packages = [
      pkgs.godotPackages_4_6.godot
    ];
  };
}    