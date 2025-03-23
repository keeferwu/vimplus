-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = { "vimdoc", "vim", "luadoc", "lua", "c", "cpp", "make", "kconfig", "markdown" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,
  -- 启用代码高亮功能
  highlight = {
    enable = true,
    -- use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 1000 * 1024 -- 1000 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- 启用增量选择
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    }
  },
  -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
  indent = {
    enable = false
  }
}
-- 开启 Folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99

-- codecompanion
require("codecompanion").setup({
  adapters = {
    opts = {
      -- show_defaults 会导致copilot不能正常工作
      show_defaults = true,
      language = "Chinese",
      -- log_level = "DEBUG",
    },

    deepseek = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "deepseek",
        env = {
          api_key = function()
            return os.getenv("DEEPSEEK_API_KEY")
          end,
        },
        schema = {
          model = {
            default = "deepseek-coder",
          },
        },
      })
    end,

    siliconflow_r1 = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "siliconflow_r1",
        url = "https://api.siliconflow.cn/v1/chat/completions",
        env = {
          api_key = function()
            return os.getenv("DEEPSEEK_API_KEY_S")
          end,
        },
        schema = {
          model = {
            default = "deepseek-ai/DeepSeek-R1",
            choices = {
              ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true } },
              "deepseek-ai/DeepSeek-V3",
            },
          },
        },
      })
    end,

    siliconflow_v3 = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "siliconflow_v3",
        url = "https://api.siliconflow.cn/v1/chat/completions",
        env = {
          api_key = function()
            return os.getenv("DEEPSEEK_API_KEY_S")
          end,
        },
        schema = {
          model = {
            default = "deepseek-ai/DeepSeek-V3",
            choices = {
              "deepseek-ai/DeepSeek-V3",
              ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true } },
            },
          },
        },
      })
    end,

    aliyun_deepseek = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "aliyun_deepseek",
        url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
        env = {
          api_key = function()
            return os.getenv("DEEPSEEK_API_ALIYUN")
          end,
        },
        schema = {
          model = {
            default = "deepseek-r1",
            choices = {
              ["deepseek-r1"] = { opts = { can_reason = true } },
            },
          },
        },
      })
    end,
    -- https://help.aliyun.com/zh/model-studio/getting-started/models?spm=a2c4g.11186623.0.0.ce3c4823l7PTRL#9f8890ce29g5u
    aliyun_qwen = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        name = "aliyun_qwen",
        env = {
          url = "https://dashscope.aliyuncs.com",
          api_key = function()
            return os.getenv("DEEPSEEK_API_ALIYUN")
          end,
          chat_url = "/compatible-mode/v1/chat/completions",
        },
        schema = {
          model = {
            default = "qwen-coder-plus-latest",
          },
        },
      })
    end,

    copilot_claude = function()
      return require("codecompanion.adapters").extend("copilot", {
        name = "copilot_claude",
        schema = {
          model = {
            default = "claude-3.7-sonnet",
          },
        },
      })
    end,
  },
  --选择模型
  strategies = {
    chat = { adapter = "copilot_claude" },
    inline = { adapter = "copilot_claude" },
  },

  display = {
    action_palette = {
      width = 95,
      height = 10,
      prompt = "Prompt ", -- Prompt used for interactive LLM calls
      provider = "default", -- default|telescope|mini_pick
      opts = {
        show_default_actions = true, -- Show the default actions in the action palette?
        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
      },
    },
  },
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-z>", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

