{
inputs,
pkgs,
...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/Users/mason.wu/.config/sops/age/keys.txt";
    defaultSopsFile = "/Users/mason.wu/nix-config/secrets/test-sec.yaml";
    secrets.test = {
      sopsFile = "/Users/mason.wu/nix-config/secrets/test-sec.yaml"; 
      sops.secrets.example-key = {
         path = "/Users/mason.wu/example-key.txt"; 
      };
      sops.secrets."nested/level1" = {};
    };
  };
};
