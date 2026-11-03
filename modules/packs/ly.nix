{
  inputs,
  ...
}:
{
  flake.modules.nixos.ly = { pkgs, ... }: {
    services.displayManager.ly.enable = true;
  };
}    
