{
  inputs,
  ...
}:
{
  flake.modules.nixos.sops = {
    imports = [
      inputs.sops.nixosModules.sops
    ];
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.sops
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

    # sops.defaultSopsFile = ../../secrets//example.yaml;
    # sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    # sops.secrets.example_key = {};
  };

  flake.modules.homeManager.sops = {
  };
}