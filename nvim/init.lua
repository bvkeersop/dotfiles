if vim.g.vscode then
  require "user.vscode_keymaps"
else
  require "user"
end