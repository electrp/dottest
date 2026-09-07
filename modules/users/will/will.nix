{
  inputs,
  ...
}:
let
  username = "will";
in {
  flake.modules.nixos."${username}"= 
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      imports = with inputs.self.modules.nixos; [
        niri code firefox terminal discord steam godot direnv dolphin pipewire musnix kde
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];

      home-manager.users."${username}" = {
        imports = [
          inputs.self.modules.homeManager."${username}"
        ];
      };


      fonts = {
        enableDefaultPackages = true; # Ensures basic default system fonts are present
        
        # Crucial for older desktop environments or specific GTK/GNOME setups
        fontDir.enable = true; 

        packages = with pkgs; [
          noto-fonts
          noto-fonts-cjk-sans
          fira-code
          dejavu_fonts
          freefont_ttf
          noto-fonts
          # Add any other fonts you expect GNOME to use here
        ];
      };

      users.users."${username}" = {
        isNormalUser = true;
        initialPassword = "changeme";
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" ]; # Add "wheel" here
      };

      programs.zsh.enable = true;
      services.openssh.enable = true;

      # Enable udisks2 (usually needed for gnome-disks/thunar)
      services.udisks2.enable = true;
      # Recommended: Enable gvfs for userspace mounting in file managers
      services.gvfs.enable = true;


      # TODO: Add elsewhere
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      environment.systemPackages = [
        pkgs.git
        pkgs.gh

        # TODO: Get platform using varaible so this is portable
        inputs.tidaLuna.packages.x86_64-linux.default
        pkgs.surge-xt 
        pkgs.vital
        pkgs.zynaddsubfx
        pkgs.decent-sampler
        pkgs.neural-amp-modeler-lv2
        pkgs.kdePackages.kwallet
        pkgs.kdePackages.kio
        pkgs.kdePackages.kio-fuse
        pkgs.kdePackages.kio-extras
        pkgs.kdePackages.qtwayland
        pkgs.libsForQt5.qt5.qtwayland
      ];

      services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess"
      '';

      services.flatpak.enable = true;
      programs.kdeconnect.enable = true;


      security.pam.services = {
        login.kwallet.enable = true;
        kwallet.enable = true;
        # Or use your specific username if needed, e.g., security.pam.services.<your-username>.kwallet.enable = true;
      };

      programs.partition-manager.enable = true;
    };
  
  flake.modules.homeManager."${username}" = { pkgs, ... }:
  {
    home.username = "${username}";
    home.stateVersion = "26.05";

    home.packages = with pkgs; [
      libreoffice-still
      jetbrains.rider
      jetbrains.clion
      reaper
      kdePackages.plasma-systemmonitor
      prismlauncher
      # surge
      yabridgectl
      bs-manager
      (pkgs.yabridge.overrideAttrs (oldAttrs: { wine = pkgs.wineWowPackages.staging; }))
      lutris 
    ];
  };
}