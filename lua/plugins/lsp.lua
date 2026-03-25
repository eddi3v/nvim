local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Add additional capabilities supported by nvim-cmp
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Setup clangd (C/C++ Language Server) using the new Neovim 0.11+ API
vim.lsp.config('clangd', {
    cmd = { 
        "C:\\Program Files\\LLVM\\bin\\clangd.exe", 
        "--background-index", 
        "--clang-tidy", 
        "--log=verbose",
        "--query-driver=C:\\Program Files\\Microsoft Visual Studio\\*\\*\\VC\\Tools\\MSVC\\*\\bin\\Hostx64\\x64\\cl.exe"
    },
    capabilities = capabilities,
})

-- Enable the server to automatically attach to relevant files
vim.lsp.enable('clangd')

-- Global diagnostic mappings
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = 'Go to definition' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = 'Hover Documentation' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'Code Action' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = 'Rename symbol' })
  end,
})

-- Optional: You can easily add other language servers here later
-- vim.lsp.config('pyright', { capabilities = capabilities })
-- vim.lsp.enable('pyright')
