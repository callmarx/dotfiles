local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- -- NORMAL MODE SHORTCUTS -- --
keymap("n", "<C-L>", ":nohls<CR><C-L>", opts) -- Clear highlighted search.
keymap("n", "<leader>q", ":bp<cr>:bd #<cr>", opts) -- Close the buffer without closing the window (doesn't close your :split).
keymap("n", "<leader>f", ":Format<cr>", opts) -- Calls formatter

-- Telescope
--- live grep requires ripgrep: sudo pacman -S ripgrep
keymap("n", "<leader>tf", ":lua require('telescope.builtin').find_files({layout_config={width=0.99,height=0.99}})<cr>", opts)
keymap("n", "<leader>tg", ":lua require('telescope.builtin').live_grep({layout_config={width=0.99,height=0.99}})<cr>", opts)
keymap("n", "<leader>tm", ":lua require('telescope').extensions.media_files.media_files({layout_config={width=0.99,height=0.99}})<cr>", opts)
-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Fugitive
-- NOTE: I only use tab-pages for fugitive plugin
vim.cmd[[
function! CleanNoNameEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
  if !empty(buffers)
    exe 'bd '.join(buffers, ' ')
  else
    echo 'No buffer deleted'
  endif
endfunction
]]
-- Closes current tab-page (and delete eventual unnamed empty buffers)
-- NOTE: This command is more like a 'exit' to the fugitive features.
keymap("n", "<leader>tc", ":tabclose<CR>:call CleanNoNameEmptyBuffers()<CR>", opts)
-- Same as 'git add -A'.
keymap("n", "<leader>ga", ":Git add -A<CR>", opts)
-- Open a COMMIT_EDITMSG same as 'git commit --verbose' with editor
keymap("n", "<leader>gc", ":tab Git commit --verbose<CR>", opts)
-- Same as 'git push'.
keymap("n", "<leader>gsh", ":Git push<CR>", opts)
-- Same as 'git pull'.
keymap("n", "<leader>gll", ":Git pull<CR>", opts)
-- Open a temporary buffer with uncommitted files that each can be expand
-- with '=' to show details (toggling).
keymap("n", "<leader>gg", ":tab Git<CR>", opts)
-- Open two temporary buffers with detailed commit history.
keymap("n", "<leader>gL", ":tabnew<CR>:Gclog<CR>", opts)
-- Open a temporary buffer with maps for additional triage. Press enter
-- on a line to view the commit where the line changed, or 'g?' to see other available maps. Omit
-- the filename argument will be blame the currently edited file in a vertical split.
keymap("n", "<leader>gb", ":tab Git blame<CR>", opts)
-- Open a staged version of the file side by side with the working tree
-- version. Use Vim's diff handling capabilities to apply changes to the staged version, and write
-- that buffer to stage the changes. You can also give an arbitrary ':Gedit' argument to diff
-- against older versions of the file.
keymap("n", "<leader>gD", ":tab Gvdiffsplit<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- -- INSERT MODE SHORTCUTS -- --

-- -- VISUAL MODE SHORTCUTS -- --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
