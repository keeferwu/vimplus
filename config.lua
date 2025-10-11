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
      "markdown_inline",
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
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
-- vim.wo.foldlevel = 99

-- render-markdown.nvim
require('render-markdown').setup({
    --渲染 markdown 和 codecompanion 文件类型
    file_types = { 'markdown', 'codecompanion' },
    latex = { enabled = false }
})

-- codecompanion.nvim
require("codecompanion").setup({
  opts = {
    log_level = "DEBUG", -- TRACE|DEBUG|ERROR|INFO
    language = "Chinese", -- The language used for LLM responses
    -- If this is false then any default prompt that is marked as containing code
    -- will not be sent to the LLM. Please note that whilst I have made every
    -- effort to ensure no code leakage, using this is at your own risk
    send_code = true,
    job_start_delay = 1500, -- Delay in milliseconds between cmd tools
    submit_delay = 2000, -- Delay in milliseconds before auto-submitting the chat buffer
  },
  -- option default set:codecompanion.nvim/lua/codecompanion/config.lua
  display = {
    action_palette = {
      width = 95,
      height = 10,
      prompt = "Prompt ", -- Prompt used for interactive LLM calls
      --provider = "default", -- default|telescope|mini_pick
      opts = {
        show_default_actions = true, -- Show the default actions in the action palette?
        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
      },
    },
    chat = {
      auto_scroll = true, -- Automatically scroll down and place the cursor at the end?
      show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
      separator = "─", -- The separator between the different messages in the chat buffer
      show_context = true, -- Show context (from slash commands and variables) in the chat buffer?
      fold_context = false, -- Fold context in the chat buffer?
      fold_reasoning = false, -- Fold the reasoning content from the LLM in the chat buffer?
      show_settings = false, -- Show LLM settings at the top of the chat buffer?
      show_tools_processing = true, -- Show the loading message when tools are being executed?
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
    http = {
      opts = {
        allow_insecure = false, -- Allow insecure connections?
        cache_models_for = 1800, -- Cache adapter models for this long (seconds)
        proxy = nil, -- [protocol://]host[:port] e.g. socks5://127.0.0.1:9999
        show_defaults = false, -- not Show default adapters
        show_model_choices = true, -- Show model choices when changing adapter
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
                ["deepseek-coder"] = { opts = { can_use_tools = true } },
                ["deepseek-reasoner"] = { opts = { can_reason = true, can_use_tools = false } },
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
                ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true, can_use_tools = false } },
                ["deepseek-ai/DeepSeek-V3"]  = { opts = { can_use_tools = true } },
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
                ["deepseek-ai/DeepSeek-V3"]  = { opts = { can_use_tools = true } },
                ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true, can_use_tools = false } },
              },
            },
          },
        })
      end,
      --[[
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
      end,
      ]]
    },
    acp = {
      claude_code = "claude_code",
      gemini_cli = "gemini_cli",
      opts = {
        show_defaults = true, -- Show default adapters
      },
    },
  },
  -- extensions
  extensions = {
    history = {
      enabled = true,
      opts = {
        -- Keymap to open history from chat buffer (default: gh)
        keymap = "gh",
        -- Keymap to save the current chat manually (when auto_save is disabled)
        save_chat_keymap = "sc",
        -- Save all chats by default (disable to save only manually using 'sc')
        auto_save = false,
        -- Number of days after which chats are automatically deleted (0 to disable)
        expiration_days = 0,
        -- Picker interface (auto resolved to a valid picker)
        picker = "default", --- ("telescope", "snacks", "fzf-lua", or "default")
        -- Optional filter function to control which chats are shown when browsing
        chat_filter = nil, -- function(chat_data) return boolean end
        -- Customize picker keymaps (optional)
        picker_keymaps = {
          rename = { n = "r", i = "<M-r>" },
          delete = { n = "d", i = "<M-d>" },
          duplicate = { n = "<C-y>", i = "<C-y>" },
        },
        ---Automatically generate titles for new chats
        auto_generate_title = true,
        title_generation_opts = {
          ---Adapter for generating titles (defaults to current chat adapter)
          adapter = nil, -- "copilot"
          ---Model for generating titles (defaults to current chat model)
          model = nil, -- "gpt-4o"
          ---Number of user prompts after which to refresh the title (0 to disable)
          refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
          ---Maximum number of times to refresh the title (default: 3)
          max_refreshes = 3,
          format_title = function(original_title)
              -- this can be a custom function that applies some custom
              -- formatting to the title.
              return original_title
          end
        },
        ---On exiting and entering neovim, loads the last chat on opening chat
        continue_last_chat = false,
        ---When chat is cleared with `gx` delete the chat from history
        delete_on_clearing_chat = true,
        ---Directory path to save the chats
        dir_to_save = vim.fn.expand('~/.vim/cache') .. "/codecompanion-history",
        ---Enable detailed logging for history extension
        enable_logging = false,
        -- Summary system
        summary = {
            -- Keymap to generate summary for current chat (default: "gcs")
            create_summary_keymap = "gcs",
            -- Keymap to browse summaries (default: "gbs")
            browse_summaries_keymap = "gbs",
            generation_opts = {
                adapter = nil, -- defaults to current chat adapter
                model = nil, -- defaults to current chat model
                context_size = 90000, -- max tokens that the model supports
                include_references = true, -- include slash command content
                include_tool_outputs = true, -- include tool execution results
                system_prompt = nil, -- custom system prompt (string or function)
                format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
            },
        },
        -- Memory system (requires VectorCode CLI)
        memory = {
            -- Automatically index summaries when they are generated
            auto_create_memories_on_summary_generation = true,
            -- Path to the VectorCode executable
            vectorcode_exe = "vectorcode",
            -- Tool configuration
            tool_opts = { 
                -- Default number of memories to retrieve
                default_num = 10 
            },
            -- Enable notifications for indexing progress
            notify = true,
            -- Index all existing memories on startup
            -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
            index_on_startup = false,
        },
      }
    }
  }
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-x>", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

function codecompanion_notify_by_fidget()
  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})
  local fidget_handles = {}

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    callback = function(request)
      local llm_role_title = function(adapter)
        local parts = {}
        table.insert(parts, adapter.formatted_name)
        if adapter.model and adapter.model ~= "" then
          table.insert(parts, "(" .. adapter.model .. ")")
        end
        return table.concat(parts, " ")
      end
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

-- fidget.nvim
require("fidget").setup {
    --option
}

