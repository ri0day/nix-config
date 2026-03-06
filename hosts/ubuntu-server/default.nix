{ config, pkgs, lib, username, ... }:

{
  # ============================================
  # Home Manager standalone configuration
  # (No system-level config - Ubuntu manages that)
  # ============================================

  # Home directory
  home.homeDirectory = "/home/${username}";

  # Packages for this server
  home.packages = with pkgs; [
    # Server CLI tools
    htop
    iotop
    ncdu
    tmux
    git
    ripgrep
    fd
  ];

  # Shell configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Mason Wu";
    userEmail = "admin@example.com";
  };

  # SSH configuration
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/github_key";
      };
    };
  };

  # Secrets
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      # server-api-key = {};
    };
  };

  # Services (via systemd user services)
  # services = {
  #   # Example: enable a user service
  # };
}
