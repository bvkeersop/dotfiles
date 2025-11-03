-- Keymap helper
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true } -- non-recursive, silent

-- ===============================
-- Leader key setup
-- ===============================
-- Set the leader key to Space (easy to reach)
keymap("n", "<Space>", "", opts)  -- clear default Space mapping in normal mode
vim.g.mapleader = " "             -- global leader
vim.g.maplocalleader = " "        -- local leader (buffer-specific)

-- ===============================
-- Clipboard mappings
-- ===============================
-- Yank (copy) to system clipboard
keymap("n", "<leader>y", '"+y', opts)
-- keymap("v", "<leader>y", '"+y', opts)  -- visual mode (commented out)

-- Paste from system clipboard
keymap("n", "<leader>p", '"+p', opts)
-- keymap("v", "<leader>p", '"+p', opts)  -- visual mode (commented out)

-- ===============================
-- Neovim improvements (commented out for now)
-- ===============================
-- Better indenting in visual mode
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- Move selected text up and down
-- keymap("v", "J", ":m .+1<CR>==", opts)
-- keymap("v", "K", ":m .-2<CR>==", opts)
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Paste without overwriting yank buffer
-- keymap("v", "p", '"_dP', opts)

-- ===============================
-- Clear search highlighting
-- ===============================
-- Press Escape to clear search highlights
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

-- ===============================
-- VSCode-specific keymaps
-- ===============================
-- General VSCode actions
keymap("n", "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
-- keymap("v", "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")  -- visual mode (optional)
keymap("n", "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
keymap("n", "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap("n", "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap("n", "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
keymap("n", "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
keymap("n", "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap("n", "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
keymap("n", "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
keymap("n", "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")

-- ===============================
-- Harpoon keymaps (quick file navigation)
-- ===============================
keymap("n", "<leader>ha", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
keymap("n", "<leader>ho", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
keymap("n", "<leader>he", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
keymap("n", "<leader>h1", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
keymap("n", "<leader>h2", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
keymap("n", "<leader>h3", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
keymap("n", "<leader>h4", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
keymap("n", "<leader>h5", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
keymap("n", "<leader>h6", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
keymap("n", "<leader>h7", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
keymap("n", "<leader>h8", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
keymap("n", "<leader>h9", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

-- ===============================
-- Project Manager keymaps
-- ===============================
-- Save the current workspace as a project
keymap("n", "<leader>pa", "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
-- keymap("v", "<leader>pa", "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")  -- visual mode (commented)

-- Open project in a new window
keymap("n", "<leader>po", "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")
-- keymap("v", "<leader>po", "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")  -- visual mode

-- Edit saved projects
keymap("n", "<leader>pe", "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")
-- keymap("v", "<leader>pe", "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")  -- visual mode
