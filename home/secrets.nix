{
config,
...
}: {
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets.hello = {
    sopsFile = "/tmp/test-sec.yaml";
       path = "/tmp/mason-hello.txt";
      };
    secrets."nested/level1" = {
    sopsFile = "/tmp/test-sec.yaml";
       path = "/tmp/mason-nested-level1.txt";
      };
    };
  }
