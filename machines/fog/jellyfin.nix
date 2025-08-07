{ config, lib, pkgs, ... }:

{
  services.jellyfin = {
	  enable = true;
		user = "hugo";
		group = "users";
		openFirewall = true;
	};

	hardware.graphics = {
	  enable = true;
		extraPackages = with pkgs; [
		  intel-media-driver
			libva-vdpau-driver
			intel-compute-runtime-legacy1
		];

		extraPackages32 = with pkgs.driversi686Linux; [
		  intel-media-driver
			libva-vdpau-driver
		];
	};

	environment.systemPackages = with pkgs; [
			libva-utils
			vdpauinfo
	];
}
