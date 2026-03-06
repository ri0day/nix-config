{ inputs }:

{ name, system, username, useremail, modules }:

inputs.darwin.lib.darwinSystem {
  inherit system;

  specialArgs = {
    inherit inputs username useremail;
    hostname = name;
    isDarwin = true;
    isLinux = false;
  };

  modules = [
    # Core shared modules
    ../modules/shared/nix-core.nix
    ../modules/shared/users.nix

    # Darwin-specific modules
    ../modules/darwin/system.nix
    ../modules/darwin/homebrew.nix

    # Home Manager integration
    inputs.home-manager.darwinModules.home-manager
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
            ../home/darwin
          ];
        };
        extraSpecialArgs = {
          inherit inputs username useremail;
          hostname = name;
          isDarwin = true;
          isLinux = false;
        };
      };
    }

    # SOPS
    inputs.sops-nix.darwinModules.sops

    # Host-specific modules (last, for overrides)
  ] ++ modules;
}
