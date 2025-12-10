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
              endpoint = "s3.us-east-005.backblazeb2.com";
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
