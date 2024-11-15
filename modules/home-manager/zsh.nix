{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;

    syntaxHighlighting.enable = true;

    shellAliases = {
      # NixOS
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#default";
      collect-garbage = "sudo nix-collect-garbage -d";
      configure = "code /etc/nixos";

      # Nix shells
      dev = "nix develop /etc/nixos#default";
      dev-tauri = "nix develop /etc/nixos#tauri --impure";
      dev-work = "nix develop /etc/nixos#work --impure";
    };

    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
    };
  };

}
