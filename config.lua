-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = {
      "vimdoc",
      "bash",
      "c",
      "cpp",
      "make",
      "yaml",
      "markdown",
      "python",
      "rust",
      "lua",
  },
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
    -- language = "Chinese",
    log_level = "DEBUG", -- TRACE|DEBUG|ERROR|INFO
  },
  -- option default set:codecompanion.nvim/lua/codecompanion/config.lua
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
      adapter = "siliconflow_r1", -- copliot|deepseek|siliconflow|aliyun_deepseek
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
      slash_commands = {
        ["chinese"] = {
          description = "language response",
          callback = function(chat)
            chat:add_buf_message({ content = "-所有非代码文本的回复使用中文语言。" })
          end,
          opts = {
            contains_code = false,
          },
        },
      },
    },
    inline = {
      adapter = "siliconflow_v3", -- copliot|deepseek|siliconflow|aliyun_deepseek
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
      adapter = "siliconflow_v3", -- copliot|deepseek|siliconflow|aliyun_deepseek
    },
  },
  -- prompt_library for codecompanionaction
  prompt_library = {
    ["Unit Tests"] = {
      -- change strategy to chat
      strategy = "chat",
    },
    ["Generate a Commit Message"] = {
      opts = {
        auto_submit = false,
        -- use specific adapter
        adapter = {
          name = "siliconflow_v3",
          model = "deepseek-ai/DeepSeek-V3",
        },
      },
    },
  },
  -- adapter extensions
  adapters = {
    opts = {
      -- show default adapter
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

    deepseek_coder = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "deepseek_coder",
        env = {
          api_key = function()
            return os.getenv("DEEPSEEK_API_KEY")
          end,
        },
        schema = {
          model = {
            default = "deepseek-coder",
            choices = {
              "deepseek-coder",
              "deepseek-chat",
              ["deepseek-reasoner"] = { opts = { can_reason = true } },
            },
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
            return os.getenv("SILICONFLOW_API_KEY")
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
            return os.getenv("SILICONFLOW_API_KEY")
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
            return os.getenv("ALIYUN_API_KEY")
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
    --[[
    -- https://help.aliyun.com/zh/model-studio/getting-started/models?spm=a2c4g.11186623.0.0.ce3c4823l7PTRL#9f8890ce29g5u
    aliyun_qwen = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        name = "aliyun_qwen",
        env = {
          url = "https://dashscope.aliyuncs.com",
          api_key = function()
            return os.getenv("ALIYUN_API_KEY")
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
})

vim.keymap.set({ "n", "v" }, "<leader>oa", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>oc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- fidget.nvim
require("fidget").setup {
    --option
}

function llm_role_title(adapter)
  local parts = {}
  table.insert(parts, adapter.formatted_name)
  if adapter.model and adapter.model ~= "" then
    table.insert(parts, "(" .. adapter.model .. ")")
  end
  return table.concat(parts, " ")
end

function codecompanion_notify_by_fidget()
  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})
  local fidget_handles = {}

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    callback = function(request)
      local handle = require("fidget.progress").handle.create({
        title = "",
        -- title = " Thinking... (" .. request.data.strategy .. ")",
        message = " Thinking... (" .. request.data.strategy .. ")",
        lsp_client = {
          name = llm_role_title(request.data.adapter),
        },
      })
      fidget_handles[request.data.id] = handle
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestFinished",
    group = group,
    callback = function(request)
      local handle =  fidget_handles[request.data.id]
      fidget_handles[request.data.id] = nil
      if handle then
        if request.data.status == "success" then
          handle.message = "Completed"
        elseif request.data.status == "error" then
          handle.message = " Error"
        else
          handle.message = "󰜺 Cancelled"
        end
        handle:finish()
      end
    end,
  })
end
codecompanion_notify_by_fidget()
