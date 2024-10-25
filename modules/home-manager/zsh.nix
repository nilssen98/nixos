{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ starship ];

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;

    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#default";
      collect-garbage = "sudo nix-collect-garbage -d";
    };

    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      # theme = "robbyrussell";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      ];
    };
  };

  programs.starship = {
    enable = true;

    # Configuration written to ~/.config/starship.toml
    settings =
      (
        with builtins; fromTOML (readFile "${pkgs.starship}/share/starship/presets/bracketed-segments.toml")
      )
      // {
        # overrides here, may be empty
      };
  };
}