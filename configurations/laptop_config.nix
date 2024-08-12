# This is the system config for my laptop

{ pkgs, ... }:

{
  imports =
    [
      ../hardware/laptop_hardware.nix
      ./hyprland.nix
    ];

  # TODO Move to default and use variables
  networking.hostName = "laptop";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
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

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -T 0.85"; } # lower
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -T 1.15"; } # raise
    ];
  };
}
