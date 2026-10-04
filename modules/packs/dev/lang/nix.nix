{
  inputs,
  ...
}:
{
  # flake.modules.nixos.code = { pkgs, ... }: {
  #   home-manager.sharedModules = [
  #   ];
  #   environment.systemPackages = [
  #     pkgs.vim
  #   ];
  #   programs.nix-ld.enable = true;
  # };

  # flake.modules.homeManager.code = {pkgs, ...}: {
  #   programs.vscode = {
  #     extensions = with pkgs.vscode-extensions; [
  #       jnoortheen.nix-ide
  #     ];
  #     profiles.default.userSettings = {
  #       "nix.enableLanguageServer" = true;
  #     };
  #   };

  # };
}    

