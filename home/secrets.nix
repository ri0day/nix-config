{
config,
...
}: {
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./test-sec.yaml;
    secrets.hello = {
       path = "/tmp/mason-hello.txt";
      };
    };
  }
