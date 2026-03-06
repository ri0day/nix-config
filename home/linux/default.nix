{ pkgs, ... }:

{
  # Non-NixOS Linux (Ubuntu, etc.) home-manager configuration
  imports = [
    # Add Linux-specific modules here
  ];

  # Linux-specific packages
  home.packages = with pkgs; [
    # Server CLI tools
    htop
    iotop
    ncdu
    tmux
  ];
}
