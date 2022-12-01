local dap = require("dap")
local e = vim.fn.expand

-- dap.set_log_level('TRACE')

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
        name = "Launch file mozart-fep",
        type = "cppdbg",
        request = "launch",
        pipeTransport = {
            debuggerPath = "usr/bin/gdb",
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
    },
    {
        name = 'Launch gdbserver mozart-fep',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:2331',
        miDebuggerPath = '/usr/bin/arm-none-eabi-gdb',
        cwd = "/workspaces/mozart-fep/",
        program = function()
            return vim.fn.input('/workspaces/mozart-fep/')
        end,
        stopAtEntry = true,
        setupCommands = setupCommands,
    },
}

dap.configurations.c = dap.configurations.cpp

