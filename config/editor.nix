let
  join = a: builtins.concatStringsSep "," a;
  makeListChars = a: join (builtins.attrValues (builtins.mapAttrs (k: v: "${k}:${v}") a));
in {
  config = {
    viAlias = true;
    vimAlias = true;

    type = "lua";

    editorconfig.enable = true;

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
      providers.xclip.enable = true;
    };

    colorschemes.tokyonight = {
      enable = true;
      style = "night";
      # transparent = true;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    options = {
      termguicolors = true;

      number = true;
      relativenumber = true;
      colorcolumn = "80";

      # paste = false;

      expandtab = true;
      smarttab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;

      list = true;
      listchars = makeListChars {
        tab = "▸▸";
        trail = "·";
      };

      mouse = "a";
      encoding = "utf-8";
      backspace = join ["indent" "eol" "start"];

      hlsearch = true;
      errorbells = false;
      splitbelow = true;
      splitright = true;
      autoread = true;
      showmode = false;
      laststatus = 2;
      fileformats = join ["unix" "dos"];
      incsearch = true;
      ignorecase = true;
      smartcase = true;
      autoindent = true;
      breakindent = true;
      magic = true;
      wrap = false;
      hidden = true;
      cmdheight = 1;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;
      completeopt = join ["menuone" "noselect"];

      # Swap
      swapfile = false;
      backup = false;
      writebackup = true;
      undofile = true;
      # undodir = "$HOME/.vim/undodir";
    };

    keymaps = [
      {
        key = "<Space>";
        mode = ["n" "v"];
        action = "<Nop>";
        options.silent = true;
      }
      {
        lua = true;
        key = "<leader>sx";
        mode = ["n"];
        action = "vim.cmd.nohlsearch";
        options.desc = "Current [S]earch [X]Clear";
      }
      {
        lua = true;
        key = "<C-K>";
        mode = ["n"];
        action = "vim.cmd.bprevious";
        options.desc = "Buffer Previous";
      }
      {
        lua = true;
        key = "<C-J>";
        mode = ["n"];
        action = "vim.cmd.bnext";
        options.desc = "Buffer Next";
      }
      {
        lua = true;
        key = "<C-L>";
        mode = ["n"];
        action = "vim.cmd.tabnext";
        options.desc = "Tab Next";
      }
      {
        lua = true;
        key = "<C-H>";
        mode = ["n"];
        action = "vim.cmd.tabprevious";
        options.desc = "Tab Previous";
      }
      {
        key = "(";
        mode = ["n" "v"];
        action = ")";
        options.noremap = true;
      }
      {
        key = "J";
        mode = ["v"];
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Move block up";
      }
      {
        key = ")";
        mode = ["n" "v"];
        action = "(";
        options.noremap = true;
      }
      {
        key = "K";
        mode = ["v"];
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Move block up";
      }
    ];
  };
}

/*
-- Buffer navigation
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>df', vim.cmd.EslintFixAll, { desc = "[D]iagnostic auto[F]ix" })


-- [[ Basic Keymaps ]]

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move code

vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "p", "\"_dP")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end
*/
