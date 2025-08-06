{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "nixos"; # Define your hostname.

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

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

  services.tlp = {
    enable = true;
    settings = {
      DEVICES_TO_DISABLE_ON_STARTUP="bluetooth";
      PLATFORM_PROFILE_ON_AC="balanced";
      PLATFORM_PROFILE_ON_BAT="low-power";
      CPU_ENERGY_PERF_POLICY_ON_AC="balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT="power";
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -T 0.85"; } # lower
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -T 1.15"; } # raise
    ];
  };

  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
  };

  programs.java.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System utilities
    graphviz
    grimblast     # hyprland screenshot utility
    swaybg
    sshpass
    wl-clipboard
    xdg-utils

    # Efficient C
    gcc
    gdb
    gnumake
    man-pages     # Needed to view linux syscall man-pages
    oprofile
    valgrind

    # Terminal programs
    conda
    kitty
    killall

    # Graphical programs
    discord
    element-desktop
    handbrake
    nautilus
    libreoffice
    obsidian
    prusa-slicer
    spotify
    tor-browser
    transmission_3
    vlc
    vscode
    zoom-us
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

