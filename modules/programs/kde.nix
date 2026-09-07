{
  inputs,
  ...
}:
{
  flake.modules.nixos.kde = { pkgs, ... }: {
    services.desktopManager.plasma6.enable = true;
  };
}    

