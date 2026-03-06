# Nix Configuration

Multi-host Nix configuration supporting Darwin (macOS), NixOS, and non-NixOS Linux (Ubuntu).

## Features

- **Multi-host support**: Define multiple machines with per-host overrides
- **Cross-platform support**: Darwin (macOS), NixOS (Linux), and non-NixOS Linux (Ubuntu)
- **Remote host management**: Deploy configurations to remote servers via deploy-rs
- **Modular structure**: Separate platform-specific code from shared code
- **Secrets management**: SOPS-nix for encrypted secrets

## Directory Structure

```
nix-config/
├── flake.nix                    # Multi-host generator
├── hosts/                       # Host-specific configurations
│   ├── m1max/                   # Personal M1 Mac (Darwin)
│   ├── work-mac/                # Work MacBook (Darwin)
│   ├── nix-server/              # NixOS server
│   └── ubuntu-server/           # Ubuntu server (Home Manager only)
├── modules/                     # System-level modules
│   ├── shared/                  # Cross-platform modules
│   ├── darwin/                  # Darwin-specific modules
│   ├── nixos/                   # NixOS-specific modules
│   └── linux/                   # Non-NixOS Linux modules
├── home/                        # Home-Manager configurations
│   ├── shared/                  # Cross-platform home config
│   ├── darwin/                  # Darwin-specific home config
│   ├── nixos/                   # NixOS-specific home config
│   └── linux/                   # Non-NixOS Linux home config
├── secrets/                     # Shared SOPS secrets
└── lib/                         # Helper functions
```

## Quick Start

### Install Nix on macOS

```bash
# Use proxy if needed: https_proxy=http://127.0.0.1:7890
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Apply Configuration

1. Backup files nix will overwrite:
```bash
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
sudo mv /etc/shells /etc/shells.before-nix-darwin
sudo mv ~/.bash_profile ~/.bash_profile.bak
sudo mv ~/.zshrc ~/.zshrc.bak
```

2. Clone and apply:
```bash
git clone git@github.com:ri0day/nix-config.git
cd nix-config
# Use proxy if needed: make useproxy proxy=http://host:port
make darwin-m1max
```

### Darwin (macOS)

```bash
# Build and switch to the configuration
make darwin-m1max

# Or directly
darwin-rebuild switch --flake .#m1max
```

### NixOS

```bash
# Build and switch to the configuration
make nixos-nix-server

# Or directly
sudo nixos-rebuild switch --flake .#nix-server
```

### Non-NixOS Linux (Ubuntu)

```bash
# Build and switch to the configuration
make home-ubuntu-server

# Or directly
home-manager switch --flake .#ubuntu-server
```

## Remote Deployment

Use deploy-rs for remote deployment:

```bash
# Deploy to a specific host
make deploy-nix-server

# Or directly
nix run .#deploy-rs -- .#nix-server
```

## Adding a New Host

1. Create a new directory in `hosts/`:

```bash
mkdir -p hosts/new-host
```

2. Create `hosts/new-host/default.nix`:

```nix
{ config, pkgs, lib, username, ... }:

{
  # Host-specific configuration
}
```

3. Add the host to `flake.nix`:

```nix
hosts = {
  # ... existing hosts
  new-host = {
    type = "darwin";  # or "nixos" or "linux"
    system = "aarch64-darwin";
    username = "your-username";
    useremail = "your-email@example.com";
    modules = [ ./hosts/new-host ];
  };
};
```

## Secrets Management

This configuration uses SOPS-nix for secrets management.

### Shared Secrets

Place secrets that should be available across all hosts in `secrets/shared.yaml`.

### Host-Specific Secrets

Place host-specific secrets in `hosts/<hostname>/secrets.yaml`.

### Editing Secrets

```bash
# Edit shared secrets
sops secrets/shared.yaml

# Edit host-specific secrets
sops hosts/m1max/secrets.yaml
```

## Useful Commands

```bash
# Update flake inputs
make update

# Update a specific input
make update-input input=nixpkgs-unstable

# Format nix files
make fmt

# Check flake
make check

# Garbage collection
make gc
```

## References

- [NixOS & Flakes Book](https://github.com/ryan4yin/nixos-and-flakes-book)
- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [Home Manager](https://github.com/nix-community/home-manager)
- [SOPS-nix](https://github.com/Mic92/sops-nix)
- [deploy-rs](https://github.com/serokell/deploy-rs)
- [ryan4yin nix template](https://github.com/ryan4yin/nix-darwin-kickstarter/)
