{ config, pkgs, ... }:

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
  home.stateVersion = "23.05"; # Please read the comment before changing.

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

  programs = {
    git = {
      enable = true;
      userName = "MugoHattsson";
      userEmail = "hu5174ma-s@student.lu.se";
    };

    bash = {
      enable = true;
    };
    
    waybar = {
      enable = true;
    };

    zsh = {
      enable = true;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
      };
    };

    wofi = {
      enable = true;
    };

    firefox = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraLuaConfig = ''
        ${builtins.readFile ./nvim/options.lua}
      '';

      plugins = with pkgs.vimPlugins; [
        {
	  plugin = comment-nvim;
	  type = "lua";
	  config = "require(\"Comment\").setup()";
	}

	{
	  plugin = gruvbox-nvim;
	  config = "colorscheme gruvbox";
	}

	lualine-nvim

      ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
