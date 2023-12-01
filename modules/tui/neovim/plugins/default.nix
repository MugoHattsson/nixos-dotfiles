{
  imports = [
    ./comment.nix
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

      nvim-colorizer.enable = true;
    };
  };
}
