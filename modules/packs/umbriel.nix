{
  inputs,
  ...
}:
{
  flake.modules.nixos.umbriel = { pkgs, ... }: {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.umbriel
    ];

    
  };

  # primarially for wayland idle
  flake.modules.homeManager.umbriel = {pkgs, ...}: {
    imports = [ inputs.umbriel.homeModules.default ];

    programs.umbriel = {
      enable = true;
      settings = {
        general.autostart = [ "noctalia" ];
        layout.gap = 5;
        input.keyboard.layout = "us";
        keybinds = {
          "Mod+Return" = "spawn kitty";
          "Mod+Q" = "window-close";
          "Mod" = "spawn noctalia msg panel-toggle launcher";
        };
      };
    };
  };
}    
