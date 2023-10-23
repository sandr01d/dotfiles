{ pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    lua-language-server
    nil # nix language server
    fd # recommended for telescope-nvim
    nodePackages.bash-language-server
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      gruvbox-nvim # gruvbox colorscheme
      vim-sleuth # automatic 'shiftwidth' & 'expandtab'
      autoclose-nvim # auto close brackets
      nvim-lspconfig # easy config for language servers
      nvim-treesitter.withAllGrammars
      nvim-cmp # completions
      cmp-nvim-lsp # completions from language server
      luasnip # snippet engine
      cmp_luasnip # snippet engine for nvim-cmp
      plenary-nvim # dependency for nvim-telescope
      telescope-nvim # nvim fuzzy finder
      telescope-fzf-native-nvim # fzf based sorter for telescope
      nvim-web-devicons # icons in telescope
    ];
    extraLuaConfig = lib.fileContents ./init.lua;
  };
}

