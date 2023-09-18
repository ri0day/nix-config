
## Nix Setup
1. install nix on macos
```bash
# https_proxy=http://127.0.0.1:7890 use proxy
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```


## apply nix-config

1. backup files nix will overwrite
```bash
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
sudo mv /etc/shells /etc/shells.before-nix-darwin
sudo mv ~/.bash_profile ~.bash_profile.bak
sudo mv ~/.zshrc ~/.zshrc.bak
```

2. pull config from github and apply changes
```bash
git clone git@github.com:ri0day/nix-config.git
cd nix-config
# `make useproxy proxy=http://host:port` if you need inject proxy settings into nix daemon
make darwin
```

## Notes:
reference from [ryan4yin nix template](https://github.com/ryan4yin/nix-darwin-kickstarter/)

