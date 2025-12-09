{
  services.caddy = {
    enable = true;
    virtualHosts."leadreacherai.com".extraConfig = ''
      encode gzip
      root * /var/www/html/leadreacherai
      file_server {
        hide .git LICENSE
      }
    '';
    virtualHosts."www.leadreacherai.com".extraConfig = ''
      encode gzip
      root * /var/www/html/leadreacherai
      file_server {
        hide .git LICENSE
      }
    '';
    virtualHosts."biotrak.app".extraConfig = ''
      reverse_proxy :8080
    '';
  };
  
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
