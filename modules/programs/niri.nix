{
  inputs,
  ...
}:
{
  flake.modules.nixos.niri = { pkgs, ... }: {
    imports = [ 
      inputs.niri-flake.nixosModules.niri
    ];
    nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];

    niri-flake.cache.enable = true;
    programs.niri.enable = true;
    programs.niri.package = pkgs.niri-unstable;
    programs.dms-shell.enable = true;

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
}