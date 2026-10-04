{
  inputs,
  ...
}:
{
  flake.modules.nixos.niri = { pkgs, ... }: {
    imports = [ 
      inputs.niri-flake.nixosModules.niri
    ];
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.niri
    ];
    nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];

    niri-flake.cache.enable = true;
    programs.niri.enable = true;
    programs.niri.package = pkgs.niri-unstable;

    environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

    environment.systemPackages = [
      pkgs.waybar
      pkgs.xwayland-satellite
      pkgs.nautilus
      pkgs.xdg-desktop-portal-gnome
    ];

    # KDE generally preferred, as thats what i'm going from
    xdg.portal = {
      enable = true;
      extraPortals = [ 
        pkgs.xdg-desktop-portal-gnome
      ];
      config.common.default = [ "gnome" ];
    };
  };

  flake.modules.homeManager.niri = { pkgs, ... }: {
    imports = [
      inputs.dms.homeModules.dank-material-shell
      inputs.dms.homeModules.niri
    ];

    programs.dank-material-shell = {
      enable = true;
      enableSystemMonitoring = true;
      # dgop.package = inputs.dgop.packages.${pkgs.system}.default;
      niri = {
        enableKeybinds = true;   # Sets static preset keybinds
        enableSpawn = true;      # Auto-start DMS with niri, if enabled
      };
    };

    programs.niri.settings = {
      
    };
  };
}