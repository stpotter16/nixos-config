{ pkgs, ...}:
{
  users.users.biodata = {
    isSystemUser = true;
    group = "biodata";
  };
  users.groups.biodata = {};

  # TODO: litestream needs group write access to coin.sqlite-shm (SQLite WAL mode
  # requirement). The coin app creates files with 0640 (group read only), so this
  # needs a manual fix after deploy:
  #   sudo chmod g+w /var/lib/coin/coin.sqlite{,-shm,-wal}
  #   sudo setfacl -d -m g::rw /var/lib/coin
  # Persist this with systemd.tmpfiles.rules once confirmed stable.

  systemd.services.biodata = {
    description = "Biodata web service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = "/opt/biodata/server";
      Restart = "always";
      Type = "simple";
      User = "biodata";
      Group = "biodata";
      StateDirectory = "biodata";
      StateDirectoryMode = "0775";
      UMask = "0007";
      EnvironmentFile = "/var/lib/biodata/secrets.env";
    };

    environment = {
        PORT = "8080";
        BIODATA_DB_PATH = "/var/lib/biodata";
    };
  };
}
