{
  inputs,
  ...
}:
{
  flake.modules.nixos.sops = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.firefox
    ];
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        # TODO: users specify
        AllowUsers = [ "will" ];
        MaxAuthTries = 3;
        PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
      };
    };
  };

  flake.modules.homeManager.sops = {
  };
}