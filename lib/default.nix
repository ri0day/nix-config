{ inputs }:

let
  mkDarwinHost = import ./mkDarwinHost.nix { inherit inputs; };
  mkNixosHost = import ./mkNixosHost.nix { inherit inputs; };
  mkLinuxHost = import ./mkLinuxHost.nix { inherit inputs; };
  utils = import ./utils.nix { inherit inputs; };

  lib = inputs.nixpkgs-unstable.lib;

  # Filter hosts by type (darwin, nixos, linux)
  filterHostsByType = hosts: type:
    lib.filterAttrs (_: config: config.type or "darwin" == type) hosts;

  # Generate deploy-rs nodes for remote deployment
  mkDeployNodes = hosts:
    lib.mapAttrs (name: config: {
      hostname = config.deploy.hostname or name;
      sshUser = config.deploy.sshUser or "root";
      profiles = {
        system = {
          user = "root";
          path = inputs.deploy-rs.lib.${config.system}.activate.${config.type} (
            if config.type == "darwin" then
              inputs.self.darwinConfigurations.${name}
            else if config.type == "nixos" then
              inputs.self.nixosConfigurations.${name}
            else
              inputs.self.homeConfigurations.${name}.activationPackage
          );
        };
      };
    }) (lib.filterAttrs (_: config: config ? deploy) hosts);

in {
  inherit mkDarwinHost mkNixosHost mkLinuxHost filterHostsByType mkDeployNodes;
  inherit lib utils;
}
