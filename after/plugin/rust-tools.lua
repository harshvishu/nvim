-- Diagnostics Handling --
--[[
local disable_buffer_diagnostics_if_necessary = function(bufnr)
    if vim.b[bufnr].diagnostics_disabled or vim.g.diagnostics_disabled then
        vim.diagnostic.disable(bufnr)
    end
end

local toggle_diagnostics = function(global)
    local vars, bufnr, cmd
    if global then
        vars = vim.g
        bufnr = nil
    else
        vars = vim.b
        bufnr = 0
    end
    vars.diagnostics_disabled = not vars.diagnostics_disabled
    if vars.diagnostics_disabled then
        vim.api.nvim_echo({ { 'Disabling diagnostics…' } }, false, {})
        cmd = 'disable'
    else
        vim.api.nvim_echo({ { 'Enabling diagnostics…' } }, false, {})
        cmd = 'enable'
    end
    vim.schedule(function() vim.diagnostic[cmd](bufnr) end)
end

local toggle_buffer_disgnostics = function()
    toggle_diagnostics(false)
end

-- Keymaps --
local setup_lsp_keymaps = function(opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    --vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.hover() end, opts)
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
    -- vim.keymap.set("i", "Find Appropriate Keymap", vim.lsp.buf.signature_help, opts)
end

local completion_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- General on_attach Stuff ---
local do_general_on_attach_stuff = function(client, bufnr)
    disable_buffer_diagnostics_if_necessary(bufnr)
    local opts = {buffer = bufnr, remap = false}
    setup_lsp_keymaps(opts)
    require('nvim-navic').attach(client, bufnr)
end
]]

-- Rust Tools --
local rt = require("rust-tools")

local mason_registry = require("mason-registry")

local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

rt.setup({
    tools = { autoSetHints = true,
    inlay_hints = { auto = true },
    hover_actions = { auto_focus = true }
},
server = {
    on_attach = function(client, bufnr)

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
        vim.keymap.set({'n', 'v'}, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>ref", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)


        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        --vim.keymap.set({"n", "v"}, "<leader>aa", rt.code_action_group.code_action_group, { buffer = bufnr })
        vim.keymap.set("n", "<leader>rdb", rt.debuggables.debuggables)
        vim.keymap.set("n", "<leader>rr", rt.runnables.runnables)
        vim.keymap.set("n", "<leader>rsh", rt.inlay_hints.set)
        vim.keymap.set("n", "<leader>rhh", rt.inlay_hints.unset)
        vim.keymap.set("n", "<leader>rmu", "<cmd>RustMoveItemUp<CR>")
        vim.keymap.set("n", "<leader>rmd", "<cmd>RustMoveItemDown<CR>")
    end,
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
                extraArgs = { "--all", "--", "-W", "clippy::all" }
            }
        }
    },
},
dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
    codelldb_path, liblldb_path)
},
})
