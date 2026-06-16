{
  inputs,
  ...
}:
{
  flake.modules.nixos.musnix = { pkgs, ... }: {
    imports = [ 
      inputs.musnix.nixosModules.musnix
    ];
    musnix.enable = true;
  };
}