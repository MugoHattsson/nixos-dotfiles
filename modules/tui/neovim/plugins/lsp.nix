{

    programs.nixvim.plugins.lsp = {
      enable = true;

      keymaps = {
        lspBuf = {
          gd = "definition";
          gD = "declaration"; # Switch to "references"?
          "<leader>lf" = "format";
          K = "hover";
          "<C-k>" = "signature_help";
        };
      };

      servers = {
        nixd = {
          enable = true;
        };
      };
    };

}
