local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

--[[
lsp.on_attach(function(client, bufnr)

  local opts = {buffer = bufnr, remap = false}


  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>fd", function() vim.diagnostic.open_float({border="single"}) end, opts)
  vim.keymap.set("n", "<leader>td", function() toggle_buffer_disgnostics() end, opts)
  vim.keymap.set({'n', 'v'}, "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>ref", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)


  --vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  --vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.hover() end, opts)
  --vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  --vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  --vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  --vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  --vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  --vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  --vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  require("lsp-inlayhints").on_attach(client, bufnr)
end)
]]

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

--require("lsp-inlayhints").setup()
--vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
--vim.api.nvim_create_autocmd("LspAttach", {
--  group = "LspAttach_inlayhints",
--  callback = function(args)
--    if not (args.data and args.data.client_id) then
--      return
--    end
--
--    local bufnr = args.buf
--    local client = vim.lsp.get_client_by_id(args.data.client_id)
--    require("lsp-inlayhints").on_attach(client, bufnr)
--  end,
--})
