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
  };
  
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
