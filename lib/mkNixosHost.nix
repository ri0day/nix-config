{ inputs }:

{ name, system, username, useremail, modules }:

inputs.nixpkgs-nixos.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs username useremail;
    hostname = name;
    isDarwin = false;
    isLinux = true;
  };

  modules = [
    # Core shared modules
    ../modules/shared/nix-core.nix
    ../modules/shared/users.nix

    # NixOS-specific modules
    ../modules/nixos/system.nix
    ../modules/nixos/networking.nix
    ../modules/nixos/services.nix

    # Home Manager integration
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
        users.${username} = {
          imports = [
            ../home/shared
            ../home/nixos
          ];
        };
        extraSpecialArgs = {
          inherit inputs username useremail;
          hostname = name;
          isDarwin = false;
          isLinux = true;
        };
      };
    }

    # SOPS
    inputs.sops-nix.nixosModules.sops

    # Host-specific modules (last, for overrides)
  ] ++ modules;
}
