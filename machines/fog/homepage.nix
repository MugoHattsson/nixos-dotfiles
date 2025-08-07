{ ... }:

{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    allowedHosts = "*";

    settings = {
      title = "Dimma";

      layout = [
        {
          Media = {
            header = true;
            style = "column";
          };
        }
      ];
    };

    services = [
      {
        "Media" = [
          {
            "Jellyfin" = {
              description = "Strömma Filmer och Serier";
              href = "http://192.168.1.6:8096";
            };
          }
        ];
      }
    ];
  };
}
