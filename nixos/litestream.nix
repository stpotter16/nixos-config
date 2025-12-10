{
  services.litestream = {
    enable = true;
    environmentFile = "/run/secrets/litestream";
    settings = {
      dbs = [
        {
          path = "/var/lib/biodata/biodata.sqlite";
          replicas = [
            {
              type = "s3";
              bucket = "biotrak";
              path = "db";
              endpoint = "TODO";
              force-path-style = true;
              retention = "168h";
              snapshot-interval = "24h";
              validation-interval = "72h";
              sync-interval = "15m";
            }
          ];
        }
      ];
    };
  };
}
