local dap = require("dap")
local e = vim.fn.expand

local setupCommands = {
  {
    text = "-enable-pretty-printing",
    description = "enable pretty printing",
    ignoreFailures = false,
  },
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/habi/.config/nvim-dap-adapters/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file (mozart-fep)",
    type = "cppdbg",
    request = "launch",
    pipeTransport = {
        debuggerPath = "/usr/bin/gdb",
        pipeProgram = "docker",
        pipeArgs = { "run", "-i", "-v", "/workspaces/mozart-fep:/workspaces/mozart-fep", "audiostreamingplatform/mozart-fep:1.41", "bash", "-c" },
        pipeCwd = "/workspaces/mozart-fep/",
    },
    program = function()
      return vim.fn.input('/workspaces/mozart-fep/')
    end,
    cwd = "/workspaces/mozart-fep/",
    stopAtEntry = true,
	setupCommands = setupCommands,
  }
}

dap.configurations.c = dap.configurations.cpp

-- load launch.json
require('dap.ext.vscode').load_launchjs()

-- require('dap.ext.vscode').load_launchjs(nil, { cppdbg = {'c', 'cpp'} })

-- Dap load launch.json when available
-- local cwd = vim.fn.expand("%:p:h")
-- if vim.fn.filereadable(cwd .. "./.vscode/launch.json") or vim.fn.filereadable(cwd .. "./launch.json") then
-- 	require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
-- end

