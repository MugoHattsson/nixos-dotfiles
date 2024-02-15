{
  imports = [
    ./autocommands.nix
    ./options.nix
    ./plugins
    ./keymappings.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
