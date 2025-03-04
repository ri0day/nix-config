{ username, ...}:

{
  # import sub modules
  imports = [
    ./zsh.nix
    ./bash.nix
    ./core.nix
    ./git.nix
    ./ssh.nix
    ./starship.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    stateVersion = "24.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
