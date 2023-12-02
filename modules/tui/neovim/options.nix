{
  programs.nixvim = {
    options = {
      relativenumber = true; # Relative line numbers
      number = true; # Display absolute line number of current line
      # hidden = true; # Keep closed buffer open in the background
      mouse = "a"; # Enable mouse control
      splitbelow = true; # A new window is put below the current one
      splitright = true; # A new window is put to the right of the current one

      undofile = true; # Automatically save and restore undo history
      incsearch = true; # Show match for partly typed search command
      ignorecase = true;
      smartcase = true; # Override ignorecase if the pattern includes upper-case patterns

      cursorline = true;
      signcolumn = "yes"; # Wether to show the sign column
      termguicolors = true;

      # Tab options
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true; # Expand <Tab> to spaces in Insert mode
      autoindent = true;
    };
  };
}
