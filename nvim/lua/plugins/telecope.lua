return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.1",

  dependencies = {
    "nvim-lua/plenary.nvim",

    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },

    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
  },

  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local previewers = require("telescope.previewers")
    local actions = require("telescope.actions")
    local map = vim.keymap.set

    -- =========================
    -- Disable preview for big files
    -- =========================

    local function ignore_big_files_maker(filepath, bufnr, opts)
      opts = opts or {}
      filepath = vim.fn.expand(filepath)

      vim.loop.fs_stat(filepath, function(_, stat)
        if not stat or stat.size > 500000 then
          return
        end
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      end)
    end

    -- =========================
    -- Telescope setup
    -- =========================

    telescope.setup({
      defaults = {
        buffer_previewer_maker = ignore_big_files_maker,
        path_display = { "truncate" },
        dynamic_preview_title = true,

        mappings = {
          n = {
            ["<C-b>"] = actions.delete_buffer,
          },
          i = {
            ["<C-h>"] = "which_key",
            ["<C-b>"] = actions.delete_buffer,
          },
        },
      },

      extensions = {
        file_browser = {
          hijack_netrw = false,
          hidden = true,
          grouped = true,
        },
      },
    })

    -- =========================
    -- Load extensions
    -- =========================

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("live_grep_args")

    -- =========================
    -- Shared options
    -- =========================

    local silent = { silent = true }

    -- =========================
    -- Project search
    -- =========================

    map("n", "<leader>fS", builtin.grep_string, silent)
    map("n", "<leader>fs", "<cmd>Telescope live_grep_args<CR>", silent)

    map("n", "<leader>fF", function()
      builtin.grep_string({
        vimgrep_arguments = {
          'rg',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '-uu',

          -- excludes (add more globs as needed)
          '--glob', '!cscope*',
        }
      })
    end, silent)

    map("n", "<leader>ff", function()
      telescope.extensions.live_grep_args.live_grep_args({
        vimgrep_arguments = {
          'rg',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '-uu',

          -- excludes (add more globs as needed)
          '--glob', '!cscope*',
        }
      })
    end, silent)

    map("n", "<leader>fg", function()
      local glob_pattern = vim.fn.input("File pattern (e.g. *.cpp, src/**/*.lua): ")
      if glob_pattern ~= "" then
        builtin.live_grep({
          glob_pattern = glob_pattern,
        })
      end
    end, silent)

    map("n", "<leader>fG", function()
      local glob_pattern = vim.fn.input("File pattern (e.g. *.cpp, src/**/*.lua): ")
      if glob_pattern ~= "" then
        builtin.grep_string({
          glob_pattern = glob_pattern,
        })
      end
    end, silent)

    -- =========================
    -- Project files
    -- =========================

    map("n", "<C-p>", builtin.find_files, silent)

    map("n", "<leader>fb", function()
      telescope.extensions.file_browser.file_browser({
        path = vim.fn.expand("%:p:h"),
      })
    end, silent)

    -- =========================
    -- Buffers
    -- =========================

    map("n", "<leader>bs", builtin.buffers, silent)

    -- =========================
    -- Hidden files
    -- =========================

    map("n", "<leader>geh", function()
      builtin.find_files({
        hidden = true,
        no_ignore = true,
      })
    end, silent)

    -- =========================
    -- LSP
    -- =========================

    map("n", "<leader>cr", function()
      builtin.lsp_references({
        layout_strategy = "vertical",
        layout_config = { width = 0.95 },
        fname_width = 60,
        trim_text = true,
        path_display = function(_, path)
          local utils = require("telescope.utils")
          local Path = require("plenary.path")

          local tail = utils.path_tail(path)
          local rel = Path:new(path):make_relative(vim.loop.cwd())
          local start = rel:match("(.-)/")

          return string.format("%s | %s", start or "", tail)
        end,
      })
    end, silent)

    map("n", "<leader>ch", vim.lsp.buf.signature_help, silent)
    map("n", "<leader>ref", builtin.lsp_references, silent)
  end,
}

