--vim.cmd([[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting()]])
vim.api.nvim_exec([[
augroup RustAutoFormat
autocmd!
autocmd BufWritePre *.rs lua vim.cmd(':RustFmt')
augroup END
]], false)

