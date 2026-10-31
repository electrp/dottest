{
  inputs,
  ...
}:
{
  flake.modules.nixos.alacritty = { pkgs, ... }: {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.alacritty
    ];

    
  };

  # primarially for wayland idle
  flake.modules.homeManager.alacritty = {pkgs, ...}: {
    programs.alacritty = {
      enable = true;
      theme = "hatsunemiku";
      settings = {
        window = {
          decorations = "None";
          padding = { x = 12; y = 12; };
        };
      };
    };
  };
}    
