{
  inputs,
  ...
}:
{
  flake.modules.nixos.sunshine = {pkgs, ...}: {
    services.sunshine = {
      enable = true;
      autoStart = true;  # optional: starts Sunshine automatically on login
      capSysAdmin = true;
      openFirewall = true;
    };

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 47984 47989 47990 48010 ];
      allowedUDPPortRanges = [
        { from = 47998; to = 48000; }
        { from = 8000; to = 8010; }
      ];
    };

    services.avahi.publish.enable = true;
    services.avahi.publish.userServices = true;
    
    services.sunshine.package = pkgs.sunshine.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages;
    };
  };
}    


