{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
			./disks.nix
      ./hardware-configuration.nix
			./samba.nix
			./jellyfin.nix
    ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

	networking = {
	  hostName = "fog";

		firewall = {
		  enable = true;
			allowPing = true;
		};
	};

  environment.systemPackages = with pkgs; [
		intel-gpu-tools
    xfsprogs
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

