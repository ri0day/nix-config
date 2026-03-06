{ pkgs, ... }:

{
  # Darwin-specific home-manager configuration
  imports = [
    # Add Darwin-specific modules here
  ];

  # Darwin-specific packages
  home.packages = with pkgs; [
    # macOS-only packages can be added here
  ];
}
