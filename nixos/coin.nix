{ pkgs, ...}:
{
  users.users.coin = {
    isSystemUser = true;
    group = "coin";
  };
  users.groups.coin = {};

  # TODO: litestream needs group write access to coin.sqlite-shm (SQLite WAL mode
  # requirement). The coin app creates files with 0640 (group read only), so this
  # needs a manual fix after deploy:
  #   sudo chmod g+w /var/lib/coin/coin.sqlite{,-shm,-wal}
  #   sudo setfacl -d -m g::rw /var/lib/coin
  # Persist this with systemd.tmpfiles.rules once confirmed stable.

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
        COIN_DB_PATH = "/var/lib/coin";
    };
  };
}
