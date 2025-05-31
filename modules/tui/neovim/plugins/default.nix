{ pkgs, ... }:
{
  imports = [
    ./comment.nix
    ./lsp.nix
    # ./python.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    plugins = {
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      # Automatically colorizes hex color-codes
      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      lualine = {
        enable = true;
      };

      rainbow-delimiters.enable = true;

      which-key.enable = true;

    };

    extraPackages = with pkgs; [
      lazygit
    ];

    extraPlugins = with pkgs.vimPlugins; [
      lazygit-nvim
    ];
  };
}
