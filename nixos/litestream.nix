{
  services.litestream = {
    enabled = true;

    environmentFile = "/run/secrets/litestream";

    settings = {
       dbs = [
         {
           path = "/var/lib/biodata/biodata.sqlite";
           replicas = [
             {
               type = "s3";
               bucket: "${BIOTRAKE_LITESTREAM_BUCKET}";
               path: "db";
               endpoint = "${BIOTRAK_LITESTREAM_ENDPOINT}";
               force-path-style = true;
               retention = "168h";
               snapshot-interval = "24h";
               validation-interval = "72h";
               sync-interval = "15m";
               access-key-id = "${BIOTRAK_LITESTREAM_ACCESS_KEY_ID}";
               secret-access-key = "${BIOTRAK_LITESTREAM_SECRET_ACCESS_KEY}";
             }
           ]
         }
       ];
    };  
  };
}
