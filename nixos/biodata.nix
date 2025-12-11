{ pkgs, ...}:
{
  users.users.biodata = {
    isSystemUser = true;
    group = "biodata";
  };
  users.groups.biodata = {};

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
