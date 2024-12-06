{
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    home-manager
    gnumake
    nixd
    nixfmt-rfc-style
    gcc
    pkg-config
    i3-gaps
    direnv
    i3lock-fancy
  ];

  # NixOS modules
  imports = [
    ./modules/nixos/bootloader.nix
    ./modules/nixos/home-manager.nix
    ./modules/nixos/xserver.nix
    ./modules/nixos/i18n.nix
    ./modules/nixos/sound.nix
    ./modules/nixos/networking.nix
    ./modules/nixos/keyboard.nix
    ./modules/nixos/users.nix
    ./modules/nixos/shell.nix
    ./modules/nixos/bluetooth.nix
    ./modules/nixos/fonts.nix
    ./modules/nixos/virtualisation.nix
    ./modules/nixos/steam.nix
    ./modules/nixos/graphics.nix
    ./modules/nixos/power.nix
    ./modules/nixos/printing.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;
  security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
      luaformatter
    ];
  };

  # Stuff for nixd LSP
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  services.gvfs.enable = true;

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "24.05";
}
