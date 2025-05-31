{

  programs.nixvim.plugins = {

    lsp = {
      enable = true;

      keymaps = {
        lspBuf = {
          gd = "definition";
          gD = "declaration"; # Switch to "references"?
          "<leader>lf" = "format";
          K = "hover";
          "<C-k>" = "signature_help";
          "<leader>ca" = "code_action";
        };
      };

      servers = {
        nixd.enable = true;

        # marksman.enable = true; # Only available on unstable
      };
    };

    lsp-lines = {
      enable = true;
      # currentLine = true;
    };
  };
}
