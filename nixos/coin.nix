{ pkgs, ...}:
{
  users.users.coin = {
    isSystemUser = true;
    group = "coin";
  };
  users.groups.coin = {};

  systemd.services.coin = {
    description = "Coin web service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = "/opt/coin/server";
      Restart = "always";
      Type = "simple";
      User = "coin";
      Group = "coin";
      StateDirectory = "coin";
      StateDirectoryMode = "0775";
      UMask = "0007";
      EnvironmentFile = "/var/lib/coin/secrets.env";
    };

    environment = {
        PORT = "8088";
        BIODATA_DB_PATH = "/var/lib/coin";
    };
  };
}
