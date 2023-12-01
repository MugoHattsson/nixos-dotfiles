{
  imports = [
    ./options.nix
    ./plugins
    ./keymappings.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true; # not yet in stable TODO: Uncomment when on 23.11
    viAlias = true;
    vimAlias = true;
  };
}
