{ config, pkgs, inputs, ... }:
  let
      myAliases = {
        ga = "git add";
        gcm = "git commit -m";
        gd = "git diff";
        gs = "git status";
      };
  in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hugo";
  home.homeDirectory = "/home/hugo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    font-awesome
    (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    
    wev
  ];

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hugo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    #EDITOR = "vim";
  };

  imports = [ 
    ./modules/gui
    ./modules/tui
  ];

  home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.graphite-cursors;
      name = "graphite-light";
      size = 16;
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
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
          package = pkgs.gnome.adwaita-icon-theme;
          name = "Adwaita";
      };

  };

  programs = {
    git = {
      enable = true;
      userName = "MugoHattsson";
      userEmail = "hu5174ma-s@student.lu.se";
    };

    bash = {
      enable = true;
      shellAliases = myAliases;
    };

    zsh = {
      enable = true;
      shellAliases = myAliases;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
      };
    };

    wofi = {
      enable = true;
    };

    kitty = {
      enable = true;
      settings = {
        font_size = 13;
        enable_audio_bell = "no";
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
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "Logout";
          keybind = "l";
        }
      ];
    };

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
        ];

      };

    };

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
