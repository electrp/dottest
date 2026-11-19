{
  inputs,
  ...
}:
{
  flake.modules.nixos.umbriel = { pkgs, ... }: {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.umbriel
    ];
    imports = [ 
      inputs.umbriel.nixosModules.default 
    ];
    programs.umbriel.enable = true;
  };

  # primarially for wayland idle
  flake.modules.homeManager.umbriel = {pkgs, ...}: {
    imports = [ 
      inputs.umbriel.homeModules.default 
      inputs.luciole.homeModules.default
    ];

    home.packages = with pkgs; [
      adw-gtk3
      nwg-look
      qtengine
    ];
  
    programs.luciole = {
      enable = true;
    };
    
    programs.umbriel = {
      enable = true;
      settings = {
        environment = {
          QT_QPA_PLATFORMTHEME="qtengine";
        };
        general.autostart = [ "noctalia" ];
        layout.gap = 5;
        include = {
          files = [ "outputs.toml" ];
        };
        input.keyboard.layout = "us";
        keybinds = {
          "Mod+Return" = "spawn kitty";
          "Mod+Q" = { action = "window-close"; repeat = false; };
          "Mod" = "spawn noctalia msg panel-toggle launcher";


          "Mod+Space" = "spawn noctalia msg panel-toggle launcher";
          "Mod+S" = "spawn noctalia msg panel-toggle control-center";
          "Mod+Shift+Comma" = "spawn noctalia msg settings-toggle";
          "Alt+Tab" = "spawn noctalia msg window-switcher hold";
          "Mod+Tab" = "overview-toggle";

          "XF86AudioRaiseVolume" = { action = "spawn noctalia msg volume-up"; allow_when_locked = true; };
          "XF86AudioLowerVolume" = { action = "spawn noctalia msg volume-down"; allow_when_locked = true; };
          "XF86AudioMute" = { action = "spawn noctalia msg volume-mute"; allow_when_locked = true; repeat = false; };
          "XF86AudioPlay" = { action = "spawn noctalia msg media toggle"; allow_when_locked = true; repeat = false; };
          "XF86AudioNext" = { action = "spawn noctalia msg media next"; allow_when_locked = true; };
          "XF86AudioPrev" = { action = "spawn noctalia msg media previous"; allow_when_locked = true; };
          "XF86MonBrightnessUp" = { action = "spawn noctalia msg brightness-up"; allow_when_locked = true; };
          "XF86MonBrightnessDown" = { action = "spawn noctalia msg brightness-down"; allow_when_locked = true; };

          # Core niri
          # Terminal and Application Launchers
          "Mod+T" = "spawn alacritty";
          "Mod+D" = "spawn fuzzel";

          # Hotkey Overlay & Shortcuts Inhibit
          # "Mod+Shift+Slash".action.show-hotkey-overlay = {};
          "Mod+Escape" = { 
            action = "shortcuts-inhibit-toggle"; 
            allow_when_inhibited = true;
            repeat = false;
          };

          # Column / Window Focus (Arrow keys & H/J/K/L)
          "Mod+Left" = "window-focus-left";
          "Mod+Down" = "window-focus-or-output-down";
          "Mod+Up" = "window-focus-or-output-up";
          "Mod+Right" = "window-focus-right";

          "Mod+R" = "window-cycle-primary-extent";
          "Mod+Shift+R" = "window-cycle-primary-extent-back";
          "Mod+Ctrl+R" = "window-cycle-secondary-extent";
          "Mod+Ctrl+Shift+R" = "window-cycle-secondary-extent-back";

          # Moving Columns / Windows
          "Mod+Ctrl+Left" = "column-move-left";
          "Mod+Ctrl+Right" = "column-move-right";
          "Mod+Ctrl+Up" = "window-move-to-workspace-previous";
          "Mod+Ctrl+Down" = "window-move-to-output-next";
          "Mod+F" = "window-toggle-maximize";
          "Mod+Shift+F" = "window-toggle-fullscreen";

          # Move workspaces between outputs
          "Mod+Ctrl+Shift+Left" = "workspace-move-to-output-previous";
          "Mod+Ctrl+Shift+Right" = "workspace-move-to-output-next";

          # Workspaces (1 through 9)
          "Mod+1" = "workspace-switch 1";
          "Mod+2" = "workspace-switch 2";
          "Mod+3" = "workspace-switch 3";
          "Mod+4" = "workspace-switch 4";
          "Mod+5" = "workspace-switch 5";
          "Mod+6" = "workspace-switch 6";
          "Mod+7" = "workspace-switch 7";
          "Mod+8" = "workspace-switch 8";
          "Mod+9" = "workspace-switch 9";

          "Mod+Shift+1" = "window-move-to-workspace 1";
          "Mod+Shift+2" = "window-move-to-workspace 2";
          "Mod+Shift+3" = "window-move-to-workspace 3";
          "Mod+Shift+4" = "window-move-to-workspace 4";
          "Mod+Shift+5" = "window-move-to-workspace 5";
          "Mod+Shift+6" = "window-move-to-workspace 6";
          "Mod+Shift+7" = "window-move-to-workspace 7";
          "Mod+Shift+8" = "window-move-to-workspace 8";
          "Mod+Shift+9" = "window-move-to-workspace 9";

          "Mod+WheelDown" = "workspace-next";
          "Mod+WheelUp" = "workspace-previous";

          # Column scrolling (Horizontal)
          "Mod+Shift+WheelUp" = "window-focus-left";
          "Mod+Shift+WheelDown" = "window-focus-right";

          # Moving windows to other workspaces using Shift + Scroll
          "Mod+Ctrl+WheelDown" = "window-move-to-workspace-next";
          "Mod+Ctrl+WheelUp" = "window-move-to-workspace-previous";

          # apps
          "Mod+L" = "spawn luciole";
        };
      };
    };
  };
}    
