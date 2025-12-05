{ 
  systemd.services.biodata = {
    description = "Biodata web service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = "/opt/biodata/server";
      Restart = "always";
      Type = "simple";
      DynamicUser = "yes";
      WorkingDirectory = "/var/lib/biodata";
    };

    environment = {
        PORT = "8080";
        BIODATA_DB_PATH = "/var/lib/biodata";
    };
  };
}
