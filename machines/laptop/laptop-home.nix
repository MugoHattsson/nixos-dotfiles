{ config, pkgs, inputs, ... }:

{
  imports = [ 
    ../../modules/gui
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    wev
  ];

  xdg.configFile = {
    "hypr/hyprland.conf".source = ../../modules/hyprland.conf;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.graphite-cursors;
      name = "graphite-light";
      size = 16;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.package = pkgs.adwaita-qt;
    style.name = "adwaita-dark";
  };

  gtk = {
      enable = true;

      cursorTheme = {
        package = pkgs.graphite-cursors;
        name = "graphite-light";
      };

      theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3-dark";
      };

      iconTheme = {
          package = pkgs.adwaita-icon-theme;
          name = "Adwaita";
      };

  };

  programs = {
    wofi.enable = true;

    thunderbird = {
      enable = true;

      profiles.hugo = {
        isDefault = true;
      };
    };

    firefox = {
      enable = true;

      profiles.hugo = {
        settings = {
          "browser.download.autohideButton" = false;
          "signon.rememberSignons" = false;
          "extensions.pocket.enabled" = false;
          "browser.toolbars.bookmarks.visibility" = "always";
        };

        # nix flake show "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons" --all-systems | grep <extension_name>
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          consent-o-matic
          videospeed
          youtube-shorts-block
          proton-pass
          duckduckgo-privacy-essentials
          sponsorblock
        ];
      };
    };

    wlogout = {
      enable = true;

      layout = [
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Power Off";
          keybind = "p";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
        }
        {
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "Logout";
          keybind = "l";
        }
      ];
    };
  };
}

