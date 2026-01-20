return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- Diagnostic keymaps
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

            -- LSP on_attach function
            local on_attach = function(client, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'cD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'cd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'cI', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
            end

            local lsp_flags = {
                debounce_text_changes = 150,
            }

            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

            vim.lsp.enable('clangd')
            vim.lsp.config('clangd', {
                on_attach = on_attach,
                cmd = {
                    "clangd",
                    "-j=3",
                    "--background-index",
                    "--header-insertion=never",
                    "--completion-style=detailed",
                    "--header-insertion-decorators=0",
                    "--query-driver=/**/mozart/**/aarch64-mozart-linux-g++,/**/mozart**/x86_64-mozart-linux-g++,/opt/toolchains/zephyr**/arm-zephyr-eabi/bin/arm-zephyr-eabi-*,/usr/bin/arm-none-eabi-*",
                },
                init_option = { fallbackFlags = { "-std=c++20" } },
                capabilities = capabilities,
            })

            vim.lsp.enable('rust_analyzer')
            vim.lsp.config('rust_analyzer', {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Disabled language servers (uncomment to enable):
            -- vim.lsp.config('dartls', { on_attach = on_attach })
            -- vim.lsp.config('pylsp', { on_attach = on_attach })
            -- vim.lsp.config('lua_ls', { on_attach = on_attach })
            -- vim.lsp.config('cmake', { on_attach = on_attach })
            -- vim.lsp.config('bashls', { on_attach = on_attach })

            -- vim.lsp.set_log_level("debug")
        end
    }
}
