{
  inputs,
  ...
}:
{
  flake.modules.nixos.firefox = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.firefox
    ];
  };

  flake.modules.homeManager.firefox = {
    programs.firefox = {
      enable = true;
    };
  };
}