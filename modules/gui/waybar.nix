{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {

      mainBar = {
        layer = "top";
	position = "bottom";
	height = 33;

	modules-left = [ 
	  "hyprland/workspaces" 
	  "hyprland/language" 
	  "hyprland/submap" 
	];
	modules-center = [ "hyprland/window" ];
	modules-right = [ 
	  "pulseaudio" 
	  "network" 
	  "battery" 
	  "clock" 
	  "tray"
	];

        "tray" = {
          # "icon-size" = 21;
          "spacing" = 10;
        };

	"clock" = {
	  "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
	};

	"battery" = {
	  "states" = {
	    "good" = 80;
	    "warning" = 30;
	    "critical" = 15;	    
	  };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          # "format-good" = ""; # An empty format will hide the module
          # "format-full" = "";
          "format-icons" = [ "" "" "" "" "" ];
	};

      
        "network" = {
            # "interface": "wlp2*"; # (Optional) To force the use of this interface
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "{ipaddr}/{cidr} ";
            "tooltip-format" = "{ifname} via {gwaddr} ";
            "format-linked" = "{ifname} (No IP) ";
            "format-disconnected" = "Disconnected ⚠";
            "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };


      };

    };
  };
}
