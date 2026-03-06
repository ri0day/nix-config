{ config, pkgs, lib, username, ... }:

{
  # ============================================
  # NixOS System Configuration
  # ============================================

  # Import hardware config
  imports = [ ./hardware.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    hostName = "nix-server";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
  ];

  # Services
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    # nginx.enable = true;
  };

  # ============================================
  # Home Manager Configuration
  # ============================================
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      ripgrep
      fd
      bat
    ];

    programs.git = {
      enable = true;
      userName = "Mason Wu";
      userEmail = "admin@example.com";
    };
  };

  # ============================================
  # Secrets configuration
  # ============================================
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      # nginx-cert = {};
    };
  };
}
