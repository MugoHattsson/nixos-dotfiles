{ config, lib, pkgs, ... }:

{
  services = {
	  samba = {
	    enable = true;
			openFirewall = true;
    
	  	settings = {
	  	  global = {
	  		  "workgroup" = "WORKGROUP";
	  			"server string" = "fog";
					"netbios name" = "fog";
	  			"security" = "user";
	  		};
    
	  		"tank" = {
	  		  "path" = "/mnt/slow";
          "guest ok" = "yes";
					"guest user" = "ftp";
					"map to guest" = "Bad User";
					"writable" = "yes";
	  		};
      };
	  };
    
	  samba-wsdd = {
	    enable = true;
	  	discovery = true;
	  };
    
	  avahi = {
	    enable = true;
    
	  	publish.enable = true;
	  	publish.userServices = true;
	  	nssmdns4 = true;
    };
  };
}
