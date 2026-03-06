{ username, isDarwin, ... }:

{
  imports = [
    ./cli-tools.nix
    ./shells/zsh.nix
    ./shells/bash.nix
    ./git.nix
    ./ssh.nix
    ./starship.nix
    ./secrets.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = username;
    homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
    stateVersion = "25.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
