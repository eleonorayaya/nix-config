local wo = vim.wo

-- Use system clipboard
vim.opt.clipboard:append("unnamedplus")

-- fill empty area below buffers with spaces
vim.opt.fillchars:append({ eob = " " })

-- Recommended session options from auto-session
vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"

vim.api.nvim_create_autocmd({"WinLeave"}, {
  pattern = { "*" },
  callback = function(ev)
    if string.find(ev.file, "NvimTree") ~= nil then
      return
    end

    wo.relativenumber	= false
    wo.number	= true
  end,
})

vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
  pattern = { "*" },
  callback = function(ev)
    if string.find(ev.file, "NvimTree") ~= nil then
      return
    end

    wo.relativenumber	= true
    wo.number	= true

    wo.signcolumn = "number";
  end,
})
