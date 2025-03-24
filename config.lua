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

-- render-markdown.nvim
require('render-markdown').setup({
    --渲染 markdown 和 codecompanion 文件类型
    file_types = { 'markdown', 'codecompanion' },
})

-- codecompanion.nvim
require("codecompanion").setup({
  opts = {
    language = "Chinese",
    log_level = "DEBUG", -- TRACE|DEBUG|ERROR|INFO
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
    chat = {
      auto_scroll = false,
      intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
      show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
      separator = "─", -- The separator between the different messages in the chat buffer
      show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
      show_settings = false, -- Show LLM settings at the top of the chat buffer?
      show_token_count = true, -- Show the token count for each response?
      start_in_insert_mode = false, -- Open the chat buffer in insert mode?
    },
  },
  --选择模型
  strategies = {
    chat = {
      adapter = "copilot",
      keymaps = {
        send = {
          modes = { n = "<C-s>", i = "<C-s>" },
        },
        close = {
          modes = { n = "<C-q>", i = "<C-q>" },
        },
        completion = {
          modes = { i = "<C-/>" },
        },
      },
    },
    inline = {
      adapter = "copilot",
      layout = "vertical", -- vertical|horizontal|buffer
      keymaps = {
        accept_change = {
          modes = { n = "ga" },
          description = "Accept the suggested change",
        },
        reject_change = {
          modes = { n = "gr" },
          description = "Reject the suggested change",
        },
      },
    },
    cmd = {
      adapter = "copilot",
    },
  },

  adapters = {
    opts = {
      -- show_defaults 会导致copilot不能正常工作
      show_defaults = false,
    },
    --[[
    copilot_claude = function()
      return require("codecompanion.adapters").extend("copilot", {
        name = "copilot_claude",
        schema = {
          model = {
            default = "claude-3.7-sonnet",
          },
        },
      })
    end,]]

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

    siliconflow = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "siliconflow",
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
    --[[
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
    end,]]
  },

  prompt_library = {
    ["DeepSeek Explain In Chinese"] = {
      strategy = "chat",
      description = "中文解释代码",
      opts = {
        is_slash_cmd = false,
        modes = { "v" },
        short_name = "explain in chinese",
        auto_submit = true,
        user_prompt = false,
        stop_context_insertion = true,
        adapter = {
          name = "aliyun_deepseek",
          model = "deepseek-r1",
        },
      },
      prompts = {
        {
          role = "system",
          content = [[当被要求解释代码时，请遵循以下步骤：

  1. 识别编程语言。
  2. 描述代码的目的，并引用该编程语言的核心概念。
  3. 解释每个函数或重要的代码块，包括参数和返回值。
  4. 突出说明使用的任何特定函数或方法及其作用。
  5. 如果适用，提供该代码如何融入更大应用程序的上下文。]],
          opts = {
            visible = false,
          },
        },
        {
          role = "user",
          content = function(context)
            local input = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
            return string.format(
  [[请解释 buffer %d 中的这段代码:

  ```%s
  %s
  ```
  ]],
              context.bufnr,
              context.filetype,
              input
            )
          end,
          opts = {
            contains_code = true,
          },
        },
      },
    },
  },
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-z>", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

