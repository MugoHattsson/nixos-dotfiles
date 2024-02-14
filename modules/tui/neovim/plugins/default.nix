{ pkgs, ... }:
{
  imports = [
    ./comment.nix
    ./treesitter.nix
    ./lsp.nix
    ./python.nix
  ];

  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };

    plugins = {
      gitsigns = {
        enable = true;
        signs = {
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

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
        };
      };

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
