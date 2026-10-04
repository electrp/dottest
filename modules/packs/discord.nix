{
  inputs,
  ...
}:
{
  flake.modules.nixos.discord = { pkgs, ... }: {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.discord
    ];

    
  };

  # primarially for wayland idle
  flake.modules.homeManager.discord = {pkgs, ...}: {
    home.packages = [
      pkgs.discord-canary
      pkgs.vesktop
    ];
  };
}    
