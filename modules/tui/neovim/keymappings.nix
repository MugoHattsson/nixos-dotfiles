{ config, lib, ... }:

{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = 
      let 
        normal = 
	  lib.mapAttrsToList ( key: action: { 
	    mode = "n"; inherit action key; 
	  })
	  {
	    "<Space>" = "<NOP>";
	    "<esc>" = ":noh<CR>"; # Esc to clear search results
      "<leader>lg" = ":LazyGit<CR>";

	    # Navigate windows
	    "<C-h>" = "<C-w>h";
	    "<C-j>" = "<C-w>j";
	    "<C-k>" = "<C-w>k";
	    "<C-l>" = "<C-w>l";
	  };
	
	visual =
	  lib.mapAttrsToList ( key: action: {
	    mode = "v"; inherit action key;
	  })
	  {
	    # better indenting 
	    ">" = ">gv";
	    "<" = "<gv";
	    "<TAB>" = ">gv";
	    "<S-TAB>" = "<gv";
	  };
      in
        config.lib.nixvim.keymaps.mkKeymaps
	{ options.silent = true; }
	( normal ++ visual );
  };
}
