-- nvim-treesitter 兼容层：<0.12 用旧 configs API，>=0.12 用新版 main API
if vim.fn.has('nvim-0.12') then
require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})
require('nvim-treesitter').install({
  'vimdoc',
  'bash',
  'c',
  'cpp',
  'make',
  'yaml',
  'html',
  'markdown',
  'markdown_inline',
  'python',
  'rust',
  'lua',
})
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserTreesitterStart', {}),
  callback = function(args)
    local max_filesize = 4000 * 1024
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end
    pcall(vim.treesitter.start, args.buf)
  end,
})
else
require('nvim-treesitter.configs').setup {
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = {
    'vimdoc',
    'bash',
    'c',
    'cpp',
    'make',
    'yaml',
    'html',
    'markdown',
    'markdown_inline',
    'python',
    'rust',
    'lua',
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
end
-- 开启 Folding
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
-- vim.wo.foldlevel = 99

-- mini.icons：文件/文件类型图标，供 mini.pick、render-markdown 等使用
require('mini.icons').setup({
  style = 'glyph',
})

-- mini.pick：codecompanion picker 依赖
require('mini.pick').setup({
  window = {
    config = {
      border = 'rounded',
    },
  },
})

-- render-markdown.nvim
require('render-markdown').setup({
    --渲染 markdown 和 codecompanion 文件类型
    file_types = { 'markdown', 'codecompanion' },
    latex = { enabled = false },
    anti_conceal = { enabled = false }
})

-- fidget.nvim
require("fidget").setup({
  notification = {
    override_vim_notify = true, -- 自动接管 vim.notify，无需再手动赋值
    filter = vim.log.levels.INFO, -- 默认 INFO，过滤 DEBUG/TRACE
    window = {
      border = "rounded",
      winblend = 0,
      max_width = 0, -- 0 表示不限制宽度
    },
  },
  progress = {
    -- 保持 false：在 insert 模式发送时也要显示进度
    suppress_on_insert = false,
    display = {
      progress_ttl = math.huge, -- 进行中一直显示
      done_ttl = 3, -- 完成后保留 3 秒
      progress_icon = { "dots" },
      done_icon = "✔",
      render_limit = 16,
    },
  },
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
          CONTEXT7_API_KEY = os.getenv("CONTEXT7_API_KEY"),
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
      adapter = "deepseek",
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
      opts = {
        completion_provider = "coc", -- blink|cmp|coc|default
      }
    },
    inline = {
      adapter = "deepseek",
    },
    cmd = {
      adapter = "deepseek",
    },
    background = {
      adapter = "deepseek",
    },
    cli = {
      agent = "pi",
      agents = {
        pi = {
          cmd = "pi",
          args = {},
          description = "Pi CLI",
          provider = "terminal",
        },
      },
      opts = {
        auto_insert = true, -- Enter insert mode when focusing the CLI terminal
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
              default = "deepseek-v4-flash",
              choices = {
                ["deepseek-v4-flash"] = { opts = { can_reason = true, can_use_tools = true } },
                ["deepseek-v4-pro"] = { opts = { can_reason = true, can_use_tools = true } },
              },
            },
          },
        })
      end,
      omniroute = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          name = "omniroute",
          url = "http://localhost:20128/v1/chat/completions",
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
  }
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-x>", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-w>", "<cmd>CodeCompanionCLI Ask<cr>", { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

local function codecompanion_notify_by_fidget()
  local ok, progress = pcall(require, "fidget.progress")
  if not ok then
    return
  end

  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })
  local handles = {}

  local STATUS = {
    success = " Completed",
    error = " Error",
    cancelled = " Cancelled",
  }

  local function finish(id, message)
    local entry = handles[id]
    if not entry then
      return
    end
    handles[id] = nil
    entry.handle.message = message
    entry.handle:finish()
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    desc = "Show a Fidget progress handle for a CodeCompanion request",
    callback = function(request)
      local data = request.data or {}
      if not data.id then
        return
      end

      -- 同一个 id 重复开始时，先结束旧 handle，避免泄漏
      if handles[data.id] then
        finish(data.id, " Superseded")
      end

      local adapter = data.adapter or {}
      local name = adapter.formatted_name or "CodeCompanion"
      if adapter.model and adapter.model ~= "" then
        name = name .. " (" .. adapter.model .. ")"
      end

      handles[data.id] = {
        bufnr = data.bufnr,
        handle = progress.handle.create({
          message = " Thinking... (" .. (data.interaction or "chat") .. ")",
          lsp_client = { name = name },
        }),
      }
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionRequestFinished",
    group = group,
    desc = "Finish the Fidget progress handle for a CodeCompanion request",
    callback = function(request)
      local data = request.data or {}
      local message = STATUS[data.status]
        or (data.interaction and " Error" or " Completed")
      finish(data.id, message)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionChatStopped",
    group = group,
    desc = "Mark in-flight Fidget handles as cancelled when a chat stops",
    callback = function(request)
      local bufnr = request.data and request.data.bufnr
      if not bufnr then
        return
      end
      for id, entry in pairs(handles) do
        if entry.bufnr == bufnr then
          finish(id, " Cancelled")
        end
      end
    end,
  })
end
codecompanion_notify_by_fidget()
