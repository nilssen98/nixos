{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    fira-code-nerdfont
    font-awesome_6
  ];
}
