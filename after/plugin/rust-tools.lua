--local rt = require("rust-tools")


-- Codelldb DAP
local mason_registry = require('mason-registry')

local codelldb = mason_registry.get_package('codelldb'):get_install_path()

local extension_path = codelldb .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"


--rt.setup({
--    -- debugging stuff
--    dap = {
--        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
--    },
--    --server = {
--    --    on_attach = function(_, bufnr)
--    --        -- Hover actions
--    --        -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
--    --        -- Code action groups
--    --        -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
--    --    end,
--    --},
--})