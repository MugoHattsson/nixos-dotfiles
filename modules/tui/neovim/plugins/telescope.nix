{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
      };
    };

    extraPackages = with pkgs; [
      ripgrep
      fd
    ];
  };
}
