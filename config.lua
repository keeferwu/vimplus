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
      "html",
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
      --provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
    },
    chat = {
      auto_scroll = true, -- Automatically scroll down and place the cursor at the end?
      show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
      separator = "─", -- The separator between the different messages in the chat buffer
      show_context = true, -- Show context (from slash commands and variables) in the chat buffer?
      fold_context = false, -- Fold context in the chat buffer?
      show_reasoning = true, -- Show reasoning content in the chat buffer?
      fold_reasoning = false, -- Fold the reasoning content from the LLM in the chat buffer?
      show_settings = false, -- Show LLM settings at the top of the chat buffer?
      show_tools_processing = true, -- Show the loading message when tools are being executed?
      show_token_count = true, -- Show the token count for each response?
      start_in_insert_mode = false, -- Open the chat buffer in insert mode?
    },
  },
  -- rule for project
  rules = {
    project = {
      description = "Rule files for current project",
      --@return boolean
      enabled = function()
        -- Don't show this group unless file exist
        return vim.fn.findfile("AGENTS.md", ".;") ~= ""
      end,
      files = {
        "AGENTS.md",
      },
    },
  },
  -- mcp server
  mcp = {
    servers = {
      ["context7"] = {
        cmd = { "npx", "-y", "@upstash/context7-mcp" },
        env = {
          CONTEXT7_API_KEY = function()
            return os.getenv("CONTEXT7_API_KEY")
          end,
        },
      },
    },
    opts = {
      default_servers = { "context7" },
    },
  },
  --选择模型
  interactions = {
    chat = {
      adapter = "omniroute",
      keymaps = {
        send = {
          modes = { n = "<C-s>", i = "<C-s>" },
        },
        close = {
          modes = { n = "<C-q>", i = "<C-q>" },
        },
        completion = {
          modes = { i = "<C-p>" },
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
      opts = {
        completion_provider = "default", -- blink|cmp|coc|default
      }
    },
    inline = {
      adapter = "omniroute",
    },
    cmd = {
      adapter = "omniroute",
    },
    background = {
      adapter = "omniroute",
    },
    cli = {
      agent = "opencode",
      agents = {
        opencode = {
          cmd = "opencode",
          args = {},
          description = "Opencode CLI",
          provider = "terminal",
        },
      },
      opts = {
        auto_insert = true, -- Enter insert mode when focusing the CLI terminal
        reload = true, -- Reload buffers when an agent modifies files on disk
      },
    },
    code_review = {
      enabled = false,
    },
  },
  -- adapter extensions
  adapters = {
    http = {
      opts = {
        allow_insecure = false, -- Allow insecure connections?
        cache_models_for = 1800, -- Cache adapter models for this long (seconds)
        proxy = nil, -- [protocol://]host[:port] e.g. socks5://127.0.0.1:9999
        show_presets = false, -- not Show default adapters
        show_model_choices = true, -- Show model choices when changing adapter
      },
      omniroute = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          name = "omniroute",
          url = "<omniroute base url>/v1/chat/completions",
          env = {
            api_key = function()
              return os.getenv("OMNIROUTE_API_KEY")
            end,
          },
          schema = {
            model = {
              default = "auto/best-coding",
              choices = {
                ["auto/best-coding"] = { opts = { can_reason = true, can_use_tools = true } },
                ["<custom combo>"]  = { opts = { can_reason = true,  can_use_tools = true } },
              },
            },
          },
        })
      end,
      orcarouter = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          name = "orcarouter",
          url = "https://api.orcarouter.ai/v1/chat/completions",
          env = {
            api_key = function()
              return os.getenv("ORCAROUTER_API_KEY")
            end,
          },
          schema = {
            model = {
              default = "orcarouter/auto",
              choices = {
                ["orcarouter/auto"] = { opts = { can_reason = true, can_use_tools = true } },
                ["openai/gpt-5.5"] = { opts = { can_reason = true } },
              },
            },
          },
        })
      end,
    },
    acp = {
      opts = {
        show_presets = false, --only display the adapters defined in your user configuration
      },
      opencode = function()
        return require("codecompanion.adapters").extend("opencode", {
          commands = {
            -- The default uses the opencode/config.json value
            default = {
              "opencode",
              "acp",
            },
          },
        })
      end,
    },
  }
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-x>", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-w>", "<cmd>CodeCompanionCLI Ask<cr>", { noremap = true, silent = true })
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
        -- title = " Thinking... (" .. request.data.interaction .. ")",
        message = " Thinking... (" .. request.data.interaction .. ")",
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

-- Relax CLI terminal readiness checks so the first prompt survives a
-- slow opencode TUI startup. Default MAX_WAIT=5s/MIN_LINES=5/STABLE_FOR=500ms
-- fires _on_ready() before opencode is reading from the PTY, dropping input.
local Terminal = require("codecompanion.interactions.cli.providers.terminal")

function Terminal:_poll_until_ready()
  local POLL_INTERVAL = 150
  local MAX_WAIT = 25000
  local MIN_LINES = 1
  local STABLE_FOR = 1500
  local started_at = vim.uv.hrtime()
  local last_count, stable_since = 0, nil
  self.poll_timer = vim.uv.new_timer()
  self.poll_timer:start(POLL_INTERVAL, POLL_INTERVAL, vim.schedule_wrap(function()
    if not self.bufnr or not vim.api.nvim_buf_is_valid(self.bufnr) then
      return self:_on_ready()
    end
    if (vim.uv.hrtime() - started_at) / 1e6 > MAX_WAIT then
      return self:_on_ready()
    end
    local count = self:_count_lines()
    if count < MIN_LINES then
      return
    end
    if count ~= last_count then
      last_count = count
      stable_since = vim.uv.hrtime()
    elseif not stable_since then
      stable_since = vim.uv.hrtime()
    elseif (vim.uv.hrtime() - stable_since) / 1e6 >= STABLE_FOR then
      return self:_on_ready()
    end
  end))
end

function Terminal:_on_ready()
  local POST_READY_DELAY = 800
  self.ready = true
  self:_close_timer("poll_timer")
  vim.defer_fn(function()
    if self.chan and not self.queue:is_empty() then
      self:_consume()
    end
  end, POST_READY_DELAY)
end

