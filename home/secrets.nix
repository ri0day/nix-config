{
config,
...
}: {
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/test-sec.yaml;
    secrets.hello = {
       path = "/tmp/mason-hello.txt";
      };
    secrets."nested/level1" = {
       path = "/tmp/mason-nested-level1.txt";
      };
    };
  }
