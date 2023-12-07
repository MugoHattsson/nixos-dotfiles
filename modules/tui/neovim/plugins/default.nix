{
  imports = [
    ./comment.nix
    ./treesitter.nix
    ./lsp.nix
    ./python.nix
  ];

  programs.nixvim = {
    colorschemes.gruvbox.enable = true;

    plugins = {
      gitsigns = {
        enable = true;
        signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };
    };
  };
}
