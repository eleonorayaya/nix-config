{
  config.opts = {
    updatetime = 100; # Faster completion
    relativenumber = true;
    number = true;

    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;

    wrap = false;

    ignorecase = true;
    smartcase = true;

    cursorline = true;

    signcolumn = "yes";

    backspace = "indent,eol,start";

    swapfile = false;

    # TODO: fix this
    clipboard = {
      register = "unnamedplus";
    };
  };
}
