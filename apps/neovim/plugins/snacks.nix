{
  plugins = {
    snacks = {
      enable = true;

      settings = {
        animate = {
          enabled = true;
          duration = 18;
          easing = "cubic";
          fps = 60;
        };
        bigfile = { enabled = true; };
        bufdelete = { enabled = true; };
        notifier = {
          enabled = true;
          timeout = 3000;
          # level = vim.log.levels.ERROR;
        };
        quickfile = { enabled = true; };
        rename = { enabled = true; };
        scope = { enabled = true; };
        scroll = { enabled = true; };
        statuscolumn = { enabled = true; };
        words = { enabled = true; };

        dashboard = { enabled = false; };
        debug = { enabled = false; };
        dim = { enabled = false; };
        explorer = { enabled = false; };
        git = { enabled = false; };
        gitbrowse = { enabled = false; };
        image = { enabled = false; };
        indent = { enabled = false; };
        input = { enabled = false; };
        layout = { enabled = false; };
        lazygit = { enabled = true; };
        picker = { enabled = false; };
        profiler = { enabled = false; };
        scratch = { enabled = false; };
        terminal = { enabled = false; };
        toggle = { enabled = false; };
        win = { enabled = false; };
        zen = { enabled = false; };
      };
    };
  };
}


