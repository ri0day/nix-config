{ config, lib, ... }:

{
  # Load shared secrets (available to all hosts)
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    # Shared secrets are loaded from secrets/shared.yaml
    # Host-specific secrets are loaded from hosts/<hostname>/secrets.yaml
  };
}
