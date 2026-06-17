{ inputs, config, lib, modulesPath, ... }:
{
	flake.nixosConfigurations = inputs.self.lib.clib.mkNixos "x86_64-linux" "la";

	flake.modules.nixos.la = {config, pkgs, ...}: 
	let
		inherit (inputs.self) outputs;
	in {
		imports = with inputs.self.modules.nixos; [
			home-manager
			will
		];

		# Hardware conf
		boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "uas" "sd_mod" "sdhci_pci" "amdgpu" "nvidia" ];
		boot.initrd.kernelModules = [ "amdgpu" ];
		boot.kernelModules = [ "kvm-amd" ];
		boot.extraModulePackages = [ ];

		fileSystems."/" =
			{ device = "/dev/disk/by-uuid/587f06a0-a79e-4a43-a76b-118acbc22f34";
				fsType = "ext4";
			};

		fileSystems."/boot" =
			{ device = "/dev/disk/by-uuid/0900-D19F";
				fsType = "vfat";
			};

		swapDevices = [ ];

		# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
		# (the default) this is the recommended approach. When using systemd-networkd it's
		# still possible to use this option, but it's recommended to use it in conjunction
		# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
		networking.useDHCP = lib.mkDefault true;
		# networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
		# networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

		nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
		hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
		hardware.enableRedistributableFirmware = true;

		# Other conf
		fileSystems."/win" = {
			device = "/dev/disk/by-uuid/48B09E3CB09E3084";
			fsType = "ntfs-3g";
			options = [
				"nofail"
			];
		};

		# nixpkgs = {
		# 	overlays = [
		# 		outputs.overlays.unstable-packages
		# 		outputs.overlays.master-packages

		# 		(self: super: {
		# 			xdg-desktop-portal-gtk = super.xdg-desktop-portal-gtk.overrideAttrs {
		# 				postInstall = ''
		# 					sed -i 's/UseIn=gnome/UseIn=gnome;sway/' $out/share/xdg-desktop-portal/portals/gtk.portal
		# 				'';
		# 			};
		# 		} )
		# 	];
		# };

		# Enable flakes and new cli
		nix.settings.experimental-features = [ "nix-command" "flakes" ];

		# Bootloader.
		boot.loader.systemd-boot.enable = true;
		boot.loader.efi.canTouchEfiVariables = true;

		networking.hostName = "la"; # Define your hostname.
		networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

		# Enable networking
		networking.networkmanager.enable = true;


		# Set your time zone.
		time.timeZone = "America/Los_Angeles";

		# Select internationalisation properties.
		i18n.defaultLocale = "en_US.UTF-8";

		i18n.extraLocaleSettings = {
			LC_ADDRESS = "en_US.UTF-8";
			LC_IDENTIFICATION = "en_US.UTF-8";
			LC_MEASUREMENT = "en_US.UTF-8";
			LC_MONETARY = "en_US.UTF-8";
			LC_NAME = "en_US.UTF-8";
			LC_NUMERIC = "en_US.UTF-8";
			LC_PAPER = "en_US.UTF-8";
			LC_TELEPHONE = "en_US.UTF-8";
			LC_TIME = "en_US.UTF-8";
		};

		programs.bash = {
			interactiveShellInit = ''
				if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
				then
					shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
					exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
				fi
			'';
		};


		# Configure keymap in X11
		services.xserver = {
			xkb = {
				layout = "us";
				variant = "";
			};
			enable = true;
			videoDrivers = [ "nvidia" "amdgpu" ];
		};

		services.displayManager.ly.enable = true;


		hardware.nvidia = {
			modesetting.enable = true;
			nvidiaSettings = true;
			open = true;
			package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
		};

		# Graphics setup
		# Enalbe OpenGL
		hardware.opengl = {
			enable = true;
			driSupport32Bit = true;
		};
		hardware.graphics = {
			enable = true;
			enable32Bit = true;
		};

		# Define a user account. Don't forget to set a password with ‘passwd’.
		users.users.will = {
			isNormalUser = true;
			description = "will";
			extraGroups = [ "networkmanager" "wheel" "samba" ];
			packages = with pkgs; [
			];
		};

		services.asusd = {
			enable = true;
		};

		services.devmon.enable = true;
		services.gvfs.enable = true;
		services.udisks2.enable = true;

		# Allow unfree packages
		nixpkgs.config.allowUnfree = true;

		# List packages installed in system profile. To search, run:
		# $ nix search wget
		environment.systemPackages = with pkgs; [
			 wget
			 neovim
			 git
			 vim
			 curl
			 tmux
			 kitty
			 supergfxctl
			 pass
			 pinentry-curses
			 gnupg
			 spotifyd
			 fish
			 libclang
			 clang-tools
			 gcc
			 gparted
			 xorg.xhost
			 kdePackages.partitionmanager
			 fastfetch 
			 hyprshot
			 mako
			 numix-icon-theme-circle
			 colloid-icon-theme
			 catppuccin-gtk
			 catppuccin-kvantum
			 catppuccin-cursors.macchiatoTeal
			 kdePackages.qtwayland
			 cmake
			libinput
			udiskie
			usbutils
			udisks
		];

		services.libinput.enable = true;


		programs.partition-manager.enable = true;

		# Enable Theme
		environment.variables.GTK_THEME = "catppuccin-macchiato-teal-standard";
		environment.variables.XCURSOR_THEME = "Catppuccin-Macchiato-Teal";
		environment.variables.XCURSOR_SIZE = "24";
		environment.variables.HYPRCURSOR_THEME = "Catppuccin-Macchiato-Teal";
		environment.variables.HYPRCURSOR_SIZE = "24";
		qt.enable = true;
		qt.platformTheme = "gtk2";
		qt.style = "gtk2";
		console = {
			earlySetup = true;
			colors = [
				"24273a"
				"ed8796"
				"a6da95"
				"eed49f"
				"8aadf4"
				"f5bde6"
				"8bd5ca"
				"ed8796"
				"a6da95"
				"eed49f"
				"8aadf4"
				"f5bde6"
				"8bd5ca"
				"a5adcb"
			];
		};

		# Override packages
		nixpkgs.config.packageOverrides = pkgs: {
			colloid-icon-theme = pkgs.colloid-icon-theme.override { colorVariants = ["teal"]; };
			catppuccin-gtk = pkgs.catppuccin-gtk.override {
				accents = [ "teal" ]; # You can specify multiple accents here to output multiple themes
				size = "standard";
				variant = "macchiato";
			};
		};

		programs.fish.enable = true;

		users.defaultUserShell = pkgs.fish;




		programs.tmux = {
			 enable = true;
			 clock24 = true;
		};

		environment.variables.EDITOR = "nvim";

		   # Setup tuigreet

		services.spotifyd = {
			enable = true;
		};

		services.pcscd.enable = true;
		programs.gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};

		systemd.services.greetd.serviceConfig = {
			Type = "idle";
			StandardInput = "tty";
			StandardOutput = "tty";
			StandardError = "journal"; # Without this errors will spam on screen
			# Without these bootlogs will spam on screen
			TTYReset = true;
			TTYVHangup = true;
			TTYVTDisallocate = true;
		};

		# Enable supergfxd
		services.supergfxd.enable = true;
		systemd.services.supergfxd.path = [ pkgs.pciutils ];

		programs.steam.gamescopeSession = {
      env = {
  			__NV_PRIME_RENDER_OFFLOAD = "1";
  			__VK_LAYER_NV_optimus = "NVIDIA_only";
  			__GLX_VENDOR_LIBRARY_NAME = "nvidia";
			};
    };
	};
}
