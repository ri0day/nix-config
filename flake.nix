{
  description = "Multi-host Nix configuration";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # Nixpkgs channels
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-nixos.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Platform frameworks
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Deployment tools
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs @ { self, ... }:
    let
      # ============================================
      # LIBRARY: Helper functions
      # ============================================
      lib = import ./lib { inherit inputs; };

      # ============================================
      # HOST DEFINITIONS: Declare all hosts here
      # ============================================
      hosts = {
        # Darwin hosts (full system config)
        m1max = {
          type = "darwin";
          system = "aarch64-darwin";
          username = "mason.wu";
          useremail = "email@me.com";
          modules = [ ./hosts/m1max ];
        };

        work-mac = {
          type = "darwin";
          system = "aarch64-darwin";
          username = "mason.wu";
          useremail = "work@company.com";
          modules = [ ./hosts/work-mac ];
        };

        # NixOS hosts (full system config)
        nix-server = {
          type = "nixos";
          system = "x86_64-linux";
          username = "mason";
          useremail = "admin@example.com";
          modules = [ ./hosts/nix-server ];
          # Deploy-rs settings
          deploy = {
            hostname = "192.168.1.100";
            sshUser = "mason";
          };
        };

        # Non-NixOS Linux hosts (Home Manager standalone)
        ubuntu-server = {
          type = "linux";  # Home Manager standalone
          system = "x86_64-linux";
          username = "mason";
          useremail = "admin@example.com";
          modules = [ ./hosts/ubuntu-server ];
          # Deploy-rs settings
          deploy = {
            hostname = "192.168.1.101";
            sshUser = "mason";
          };
        };
      };

      # ============================================
      # GENERATE OUTPUTS: Create configurations
      # ============================================
      darwinHosts = lib.filterHostsByType hosts "darwin";
      nixosHosts = lib.filterHostsByType hosts "nixos";
      linuxHosts = lib.filterHostsByType hosts "linux";

    in {
      # Darwin configurations (nix-darwin)
      darwinConfigurations = lib.lib.mapAttrs (name: config:
        lib.mkDarwinHost {
          inherit name;
          inherit (config) system username useremail modules;
        }
      ) darwinHosts;

      # NixOS configurations (full system)
      nixosConfigurations = lib.lib.mapAttrs (name: config:
        lib.mkNixosHost {
          inherit name;
          inherit (config) system username useremail modules;
        }
      ) nixosHosts;

      # Home Manager standalone configurations (for non-NixOS Linux)
      homeConfigurations = lib.lib.mapAttrs (name: config:
        lib.mkLinuxHost {
          inherit name;
          inherit (config) system username useremail modules;
        }
      ) linuxHosts;

      # Deploy-rs nodes for remote deployment
      deploy.nodes = lib.mkDeployNodes (darwinHosts // nixosHosts // linuxHosts);

      # Formatter
      formatter.aarch64-darwin = inputs.nixpkgs-unstable.legacyPackages.aarch64-darwin.alejandra;
      formatter.x86_64-darwin = inputs.nixpkgs-unstable.legacyPackages.x86_64-darwin.alejandra;
      formatter.x86_64-linux = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.alejandra;

      # nix-darwin requires this
      ids.gids.nixbld = 350;
    };
}
