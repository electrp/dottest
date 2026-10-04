{
  inputs,
  ...
}:
{
  flake.modules.nixos.pipewire = {pkgs, ...}: {
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
        raopOpenFirewall = true;
        extraConfig.pipewire-pulse."92-low-latency" = {
            context.modules = [    {
                name = "libpipewire-module-protocol-pulse";
                    args = {
                        pulse.min.req = "32/48000";
                        pulse.default.req = "32/48000";
                        pulse.max.req = "32/48000";
                        pulse.min.quantum = "32/48000";
                        pulse.max.quantum = "64/48000";
                    };
                }
            ];

            stream.properties = {
                node.latency = "32/48000";
                resample.quality = 1;
            };
        };

       extraConfig.jack = {
            "10-clock-rate" = {
                "jack.properties" = {
                    "node.latency" = "16/48000";
                    "node.rate" = "1/48000";
                    "node.lock-quantum" = true;
                };
            };
        };
 

        extraConfig.pipewire = {
            context.properties = {
                # default.clock.rate = 192000;
                #defautlt.allowed-rates = [ 192000 48000 44100 ];
                # defautlt.allowed-rates = [ 192000 ];
                default.clock.quantum = 32;
                default.clock.min-quantum = 32;
                default.clock.max-quantum = 32;
            };
        };
    };

    environment.systemPackages = [ pkgs.pulseaudio pkgs.pavucontrol ];
    users.users.will.extraGroups = [ "audio" ];
  };
}    
