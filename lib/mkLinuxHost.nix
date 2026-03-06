{ inputs }:

{ name, system, username, useremail, modules }:

inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};

  modules = [
    # Shared home config
    ../home/shared
    ../home/linux

    # SOPS
    inputs.sops-nix.homeManagerModules.sops

    # Host-specific modules (last, for overrides)
  ] ++ modules;

  extraSpecialArgs = {
    inherit inputs username useremail;
    hostname = name;
    isDarwin = false;
    isLinux = true;
  };
}
