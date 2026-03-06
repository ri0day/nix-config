{ config, pkgs, lib, username, ... }:

{
  # ============================================
  # Host-specific system configuration
  # ============================================
  # Add any m1max-specific system config here

  # ============================================
  # Home Manager configuration for this host
  # ============================================
  home-manager.users.${username} = {
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
