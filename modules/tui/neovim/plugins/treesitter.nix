{ config, ...}:

{
  programs.nixvim.plugins = {
    treesitter = 
      let
        grammars = config.programs.nixvim.plugins.treesitter.package.builtGrammars;
      in
    {
      enable = true;

      nixvimInjections = true;

      # folding = true; # Enable hiding lines by folding them away. command: zf, zo, zc
      indent = true;

      grammarPackages = with grammars; [
        lua
        nix
        python
        rust
        c
        sql
        markdown
        markdown_inline
        css
      ];
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions.enable = true;
    };
  };
}
