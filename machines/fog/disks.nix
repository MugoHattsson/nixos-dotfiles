{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [
	  mergerfs
		mergerfs-tools
		snapraid
	];

  # MergerFS

	fileSystems."/mnt/disks/data1" = {
    device = "/dev/disk/by-label/data1";
		fsType = "xfs";
  };

	fileSystems."/mnt/disks/data2" = {
    device = "/dev/disk/by-label/data2";
		fsType = "xfs";
  };

	fileSystems."/mnt/disks/data3" = {
    device = "/dev/disk/by-label/data3";
		fsType = "xfs";
  };

	fileSystems."/mnt/disks/data4" = {
    device = "/dev/disk/by-label/data4";
		fsType = "xfs";
  };

	fileSystems."/mnt/slow" = {
	  depends = [
		  "/mnt/disks/data1"
		  "/mnt/disks/data2"
		  "/mnt/disks/data3"
		  "/mnt/disks/data4"
		];
    device = "/mnt/disks/data*";
		fsType = "mergerfs";

		# First four options received from trapexit.github.io/mergerfs/quickstart/
		# Rationale being that the machine runs a kernel where version >= 6.6
		options = [
			"cache.files=off"
			"category.create=pfrd"
			"func.getattr=newest"
			"dropcacheonclose=false"

		  "defaults"
			"minfreespace=20G"
			"uid=1000"
			"gid=100"
			"fsname=slow"
		];
  };

	fileSystems."/mnt/disks/parity1" = {
    device = "/dev/disk/by-label/parity1";
		fsType = "xfs";
  };

	# SnapRAID

  services.snapraid = {
	  enable = true;
		parityFiles = [ "/mnt/disks/parity1/snapraid.parity" ];
		contentFiles = [
		  "/mnt/disks/data1/snapraid.content"
		  "/mnt/disks/data2/snapraid.content"
		  "/mnt/disks/data3/snapraid.content"
		  "/mnt/disks/data4/snapraid.content"
		];
		dataDisks = {
		  d1 = "/mnt/disks/data1";
		  d2 = "/mnt/disks/data2";
		  d3 = "/mnt/disks/data3";
		  d4 = "/mnt/disks/data4";
		};
	};
}
