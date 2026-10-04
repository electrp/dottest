{
  inputs,
  ...
}:
{
  flake.modules.nixos.code = { pkgs, ... }: {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.code
    ];
    environment.systemPackages = [
      pkgs.vim
    ];
    programs.nix-ld.enable = true;
  };

  flake.modules.homeManager.code = {pkgs, ...}: {
    programs.vscode = {
      enable = true;
      # mutableExtensionsDir = false;
      # extensions = with pkgs.vscode-extensions; [
      #   vscodevim.vim
      #   jnoortheen.nix-ide
      # ];
    };
  };
}    
