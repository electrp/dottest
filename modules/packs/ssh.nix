{
  inputs,
  ...
}:
{
  flake.modules.nixos.ssh = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.ssh
    ];
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        # SUDO: users should specify 
        AllowUsers = [ "will" ];
        MaxAuthTries = 3;
        PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
      };
    };

    # programs.ssh.startAgent = true;
  };

  flake.modules.homeManager.ssh = {
  };
}