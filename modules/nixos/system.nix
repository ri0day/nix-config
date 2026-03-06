{ pkgs, lib, ... }:

{
  # NixOS System Configuration
  # This is a stub file for future NixOS hosts

  # State version
  system.stateVersion = "25.05";

  # Bootloader
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Time zone
  # time.timeZone = "UTC";

  # Internationalisation properties
  # i18n.defaultLocale = "en_US.UTF-8";

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
  ];

  # Editor
  environment.variables.EDITOR = "vim";
}
