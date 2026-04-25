{
  services.caddy = {
    enable = true;
    virtualHosts."leadreacherai.com".extraConfig = ''
      encode zstd gzip
      root * /var/www/html/leadreacherai
      file_server {
        hide .git LICENSE
      }
    '';
    virtualHosts."www.leadreacherai.com".extraConfig = ''
      encode zstd gzip
      root * /var/www/html/leadreacherai
      file_server {
        hide .git LICENSE
      }
    '';
    virtualHosts."biotrak.app".extraConfig = ''
      encode zstd gzip
      reverse_proxy :8080
    '';
    virtualHosts."biodata.stpotter.dev".extraConfig = ''
      encode zstd gzip
      reverse_proxy :8080
    '';
    virtualHosts."coin.stpotter.dev".extraConfig = ''
      encode zstd gzip
      reverse_proxy :8088
    '';
    virtualHosts."e.stpotter.dev".extraConfig = ''
      handle /static/* {
        reverse_proxy https://us-assets.i.posthog.com:443 {
          header_up Host us-assets.i.posthog.com
          header_down -Access-Control-Allow-Origin
        }
      }
      handle /array/* {
        reverse_proxy https://us-assets.i.posthog.com:443 {
          header_up Host us-assets.i.posthog.com
          header_down -Access-Control-Allow-Origin
        }
      }
      handle {
        reverse_proxy https://us.i.posthog.com:443 {
          header_up Host us.i.posthog.com
          header_down -Access-Control-Allow-Origin
        }
      }
    '';
  };
  
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
