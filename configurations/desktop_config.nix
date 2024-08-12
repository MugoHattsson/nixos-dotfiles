# This is the system config for my desktop

{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware/desktop_hardware.nix
      ./hyprland.nix
    ];

  # Bootloader.
  boot.loader.grub.useOSProber = true;

  # TODO Move to default and use variables
  networking.hostName = "desktop";
}
