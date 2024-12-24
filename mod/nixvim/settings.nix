{
  opts = {
    number = true;
    relativenumber = true;
    undofile = true;
    wildmenu = true;
    wildignore = "*/.git/,*.lock";
    splitright = true;
    signcolumn = "yes";
    laststatus = 3;
    timeoutlen = 500;
    swapfile = false;
    cursorline = true;
    cursorlineopt = "number";

    expandtab = true;
    shiftround = true;
    shiftwidth = 4;
    tabstop = 4;
    termguicolors = true;
    lazyredraw = false;
    scrolloff = 15;
    autoread = true;
    virtualedit = "block";

    ignorecase = true;
    smartcase = true;
    hlsearch = false;
    foldenable = true;
    foldmethod = "marker";

    conceallevel = 1;
    concealcursor = "c";
  };

  clipboard.providers = {
    wl-copy.enable = true;
    xsel.enable = true;
  };

  globals = {
    tex_flavor = "latex";
    tex_conceal = "abdmg";
  };
}
