{ config, pkgs, lib, username, ... }:

{
  # ============================================
  # Host-specific system configuration
  # ============================================

  # System packages specific to this host
  environment.systemPackages = with pkgs; [
    # Work CLI tools
  ];

  # Homebrew apps for this host
  homebrew = {
    casks = [
      # Work-specific apps
    ];
    masApps = {
      # Work-specific Mac App Store apps
    };
  };

  # macOS system preferences for this host
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
    };
  };

  # ============================================
  # Home Manager configuration for this host
  # ============================================
  home-manager.users.${username} = {
    # Host-specific packages
    home.packages = with pkgs; [
      # Work apps
    ];

    # Host-specific git config
    programs.git = {
      userName = "Mason Wu";
      userEmail = "work@company.com";
    };

    # Load host-specific secrets
    sops = {
      defaultSopsFile = ./secrets.yaml;
      secrets = {
        # Add host-specific secrets here
      };
    };
  };

  # ============================================
  # Secrets configuration
  # ============================================
  sops = {
    defaultSopsFile = ./secrets.yaml;
  };
}
