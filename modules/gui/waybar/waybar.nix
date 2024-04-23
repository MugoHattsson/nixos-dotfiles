{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {

      mainBar = {
        layer = "top";
        position = "bottom";
        margin-top = 0;
        margin-bottom = 2;

        modules-left = [ 
          "hyprland/language" 
          "hyprland/submap" 
          "tray"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ 
          "bluetooth"
          "pulseaudio" 
          "network" 
          "battery" 
          "clock" 
        ];

        "hyprland/language" = {
          "format" = "{}";
          "format-en" = "US";
          "format-sv" = "SE";
        };

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

          "format" = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-alt" = "{icon} {time}";
          # "format-good" = ""; # An empty format will hide the module
          # "format-full" = "";
          "format-icons" = [ "" "" "" "" "" ];
        };


        "network" = {
          "format-wifi" = " {signalStrength}%";
          "format-ethernet" = " {ipaddr}/{cidr} ";
          "tooltip-format" = "{essid} @ {ipaddr}";
          "format-linked" = " {ifname} (No IP)";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        
        "pulseaudio" = {
          "format" = " {volume}%";
          "format-muted" = " {volume}%";
        };

        "bluetooth" = {
          "on-click" = "blueman-manager";
        };

      };
    };
  };
}
