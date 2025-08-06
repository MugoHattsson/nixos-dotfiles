{ config, pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 3;

    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hugo = {
    isNormalUser = true;
    description = "Hugo Mattsson";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  security.rtkit.enable = true; # rtkit is optional but recommended
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # zsh
  environment.shells = with pkgs; [ bash zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    fd    # replacement for the 'find' command
    git
    ncdu    # NCurses Disk Usage, terminal replacement for baobab
    neovim
    tealdeer
    unzip
    wget
  ];

  services.openssh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
