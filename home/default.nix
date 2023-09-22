{ pkgs,nixpkgs-unstable,... }:

let
  # please replace xxx with your username
  username = "mason.wu";
  alicloud-vault = pkgs.callPackage ./alicloud-vault.nix {}; #non-nixpkgs package
in
{
  # import sub modules
  imports = [
    ./zsh.nix
    ./bash.nix
    ./core.nix
    ./git.nix
    ./starship.nix
  ];
home.packages = with pkgs; [
  alicloud-vault 
  nixpkgs-unstable.legacyPackages.x86_64-darwin.otel-cli #unstable pkgs
];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
