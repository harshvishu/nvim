require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set("n", "<Leader>dt", ':DapToggleBreakpoint<CR>')
vim.keymap.set("n", "<Leader>dx", ':DapTerminate<CR>')
vim.keymap.set("n", "<Leader>do", ':DapStepOver<CR>')


-- Codelldb DAP
--local mason_registry = require('mason-registry')
--
--local codelldb = mason_registry.get_package('codelldb'):get_install_path()
--
--local extension_path = codelldb .. "/extension/"
--local codelldb_path = extension_path .. "adapter/codelldb"
--local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
--
--dap.adapters.codelldb = {
--  type = 'server',
--  port = "${port}",
--  executable = {
--    -- CHANGE THIS to your path!
--    command = extension_path, 
--    args = {"--port", "${port}"},
--
--    -- On windows you may have to uncomment this:
--    -- detached = false,
--  }
--}
