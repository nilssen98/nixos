{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

    home.packages = with pkgs; [
      pavucontrol
    ];

    programs = {
      waybar.enable = true;
      tofi = {
        enable = true;
        settings = {
          "width" = "100%";
          "height" = "100%";
          "border-width" = "0";
          "outline-width" = "0";
          "padding-left" = "35%";
          "padding-top" = "35%";
          "result-spacing" = "25";
          "num-results" = "5";
          "font" = "monospace";
          "background-color" = "#000A";
        };
      };
    };

    # Hint Electron apps to use Wayland:
    home.sessionVariables.NIXOS_OZONE_WL = "1";

    wayland.windowManager.hyprland = {
      # Enable Hyprland
      enable = true;

      # Package to use
      package = pkgs.hyprland;

      # Enable XWayland
      xwayland.enable = true;

      # Enable systemd
      systemd = {
        enable = true;
        variables = [ "--all" ];
      };

      # Settings
      settings = {
        "$mod" = "SUPER";
        "$mod+Shift" = "SUPER_SHIFT";
        "$drun" = "tofi-drun --drun-launch=true";

        exec-once = [
          "${pkgs.waybar}/bin/waybar"
        ];

        input = {
          kb_layout = "no";
        };

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bind =
          [
            "$mod, Q, killactive"
            "$mod, D, exec, $drun"
            "$mod+Shift, S, exec, grimblast copy area"
            "$mod, T, exec, alacritty"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (
              builtins.genList (
                i:
                let
                  ws = i + 1;
                in
                [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              ) 9
            )
          );
      };
    };
  };
}
