{ pkgs, ... }:

{
  # NixOS-specific home-manager configuration
  imports = [
    # Add NixOS-specific modules here
  ];

  # NixOS-specific packages
  home.packages = with pkgs; [
    # NixOS-only packages can be added here
  ];
}
