{ config, lib, username, hostname, isDarwin, isLinux, ... }:

{
  # Hostname configuration
  networking.hostName = hostname;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users."${username}" = lib.mkMerge [
    {
      description = username;
    }
    (lib.mkIf isDarwin {
      home = "/Users/${username}";
    })
    (lib.mkIf isLinux {
      home = "/home/${username}";
      isNormalUser = true;
      group = username;
    })
  ];

  # Create user group on Linux
  users.groups."${username}" = lib.mkIf isLinux { };

  nix.settings.trusted-users = [ username ];
}
