{
  inputs,
  ...
}:
{
  flake.modules.nixos.noctalia = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.noctalia
    ];
  };

  flake.modules.homeManager.noctalia = {pkgs, ...}: {
    imports = [
      # inputs.dms.homeModules.dank-material-shell
      # inputs.dms.homeModules.niri
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      settings = ../../dots/noctalia-config.toml;
    };
  };
}    