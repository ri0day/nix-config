{ config, pkgs, lib, username, ... }:

{
  # ============================================
  # Host-specific system configuration
  # ============================================
  # Homebrew packages for this host only
  homebrew.brews = [ "rtk" ];

  # ============================================
  # Home Manager configuration for this host
  # ============================================
  home-manager.users.${username} = {
    # Host-specific packages
    home.packages = with pkgs; [
      fastfetch
    ];

    # Host-specific git config
    programs.git = {
      userName = "Mason Wu";
      userEmail = "email@me.com";
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
    # Shared secrets are loaded from secrets/shared.yaml in home/shared/secrets.nix
  };
}
