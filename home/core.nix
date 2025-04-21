{pkgs, ...}: {
  home.packages = with pkgs; [
    nnn # terminal file manager
    python310
    go_1_23
    difftastic

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    inetutils #telnet
    skim #try some modern commands
    procs
    du-dust
    bottom-rs
    bat
    zoxide
    thefuck

    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # cloud devops cli
    awscli2
    aws-vault
    aliyun-cli
    kubie
    k9s
    kubectl
    kubernetes-helm 
    kubeswitch
    sops
    age
    sshuttle
    direnv
    saml2aws
    croc
    ssm-session-manager-plugin


    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # productivity
    glow # markdown previewer in terminal
    nodejs_20
  ];

  programs = {
    # modern vim
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableBashIntegration = true;
    };
    #zoxide replace cd
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    # commandline fixer
    thefuck = {
       enable = true;
       enableZshIntegration = true;
    };
  };
}
