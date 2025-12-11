{ pkgs, ...}:
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
      StateDirectory = "biodata";
      EnvironmentFile = "/var/lib/biodata/secrets.env";
      ExecStartPost =
      "+"
      + pkgs.writeShellScript "grant-db-permissions" ''
          timeout=10

          while [ ! -d /var/lib/biodata ];
          do
            if [ "$timeout" == 0 ]; then
              echo "ERROR: Timeout while waiting for /var/lib/biodata to exist"
              exit 1
            fi

            sleep 1
            ((timeout--))
          done

          find /var/lib/biodata -type d -exec chmod -v 775 {} \;
          find /var/lib/biodata -type f -exec chmod -v 660 {} \;
      '';
    };

    environment = {
        PORT = "8080";
        BIODATA_DB_PATH = "/var/lib/biodata";
    };
  };
}
