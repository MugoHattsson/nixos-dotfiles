# This is the system config for my desktop

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware/desktop_hardware.nix
    ];

  # Bootloader.
  boot.loader.grub.useOSProber = true;

  # TODO Move to default and use variables
  networking.hostName = "desktop";

  services = {

    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.latest;
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    XDG_SESSION_TYPE = "wayland";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [ 
    gnomeExtensions.appindicator
    gwe 
    protonup-qt
  ];

  programs.steam.enable = true;

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
        settings = {
          "org/gnome/desktop/interface" = {
            clock-show-weekday = true;
          };
        };
      }
    ];
  };
}
