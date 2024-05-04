{...}: {
  programs.ssh = {
  enable = true;
  matchBlocks = {
  "devopszoo" = {
    hostname = "100.84.196.17";
    user = "ubuntu";
    identityFile = "~/.ssh/id_rsa";
  };
  "github.com" = {
  hostname = "github.com";
  user = "git";
  proxyCommand = "nc -x localhost:7897 %h %p";
  };
  };

};
}
