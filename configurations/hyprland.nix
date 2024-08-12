{ pkgs, ... }:

{
  
  # Hyprland
  programs.hyprland.enable = true;

  # greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --remember --time --cmd Hyprland";
        user = "hugo";
      };
    };
  };

  services.gvfs.enable = true; # automatically mount usb disks

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    grimblast     # hyprland screenshot utility
    swaybg
    wl-clipboard
  ];

}
