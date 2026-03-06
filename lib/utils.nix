{ inputs }:

let
  lib = inputs.nixpkgs.lib;
in
{
  # Merge multiple attribute sets
  mergeAttrs = lib.foldl' lib.mergeAttrs { };

  # Check if a path exists
  pathExists = path: builtins.pathExists path;

  # Read a JSON file if it exists, otherwise return null
  readJSONIfExists = path:
    if builtins.pathExists path
    then builtins.fromJSON (builtins.readFile path)
    else null;

  # Read a YAML file if it exists (requires yaml support)
  # Note: Nix doesn't have native YAML support, this is a placeholder
  readYAMLIfExists = path:
    if builtins.pathExists path
    then builtins.trace "Warning: YAML reading not natively supported in Nix" null
    else null;

  # Generate a list of host names from a hosts attribute set
  getHostNames = hosts: lib.attrNames hosts;

  # Check if a host has deployment configuration
  hasDeployConfig = hostConfig: hostConfig ? deploy;

  # Get all hosts with deployment configuration
  getDeployableHosts = hosts:
    lib.filterAttrs (_: config: config ? deploy) hosts;
}
