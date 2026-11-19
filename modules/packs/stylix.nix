{
  inputs,
  ...
}:
{
  flake.modules.nixos.stylix = {pkgs, ...}: {
    # For hot swapping themes, look into specilaization in configs
  };
}    

