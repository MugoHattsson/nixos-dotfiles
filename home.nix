{ config, pkgs, inputs, ... }:
  let
      myAliases = {
        ga = "git add";
        gcm = "git commit -m";
        gd = "git diff";
        gs = "git status";

        ls = "eza";
        l = "eza -1";
        ll = "eza -l";
        la = "eza -laa";
        lt = "eza --tree";
        tree = "eza --tree";

        ncdu = "ncdu --color dark";
      };
  in
{
  imports = [ 
    ./modules/tui
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hugo";
  home.homeDirectory = "/home/hugo";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    font-awesome
  ];

  xdg.configFile = {
    "btop".source = ./resources/btop;
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

  home.sessionVariables = {
    #EDITOR = "vim";
  };

  programs = {
    git = {
      enable = true;
      userName = "MugoHattsson";
      userEmail = "hu5174ma-s@student.lu.se";
      extraConfig = {
        pull.rebase = true;
      };
    };

    lazygit.enable = true;

    bash = {
      enable = true;
      shellAliases = myAliases;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;

    };

    zsh = {
      enable = true;
      shellAliases = myAliases;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
      };
    };

    eza.enable = true;
    zoxide.enable = true; # cd replacement
    fzf.enable = true; # fuzzy file finder, integrates with zoxide etc.

    bat = {
      enable = true;
    };

    btop = {
      enable = true;
      settings.theme = "/home/hugo/.config/btop/themes/catppuccin_mocha.theme";
    };

    kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      settings = {
        font_size = 13;
        enable_audio_bell = "no";
      };
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
          duckduckgo-privacy-essentials
          sponsorblock
        ];
      };
    };

    ssh = {
      enable = true;
      extraConfig = 
      ''
      host remarkable
          Hostname 10.11.99.1
          User root
          Port 22
          HostkeyAlgorithms +ssh-rsa
      '';
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
