-- Concealment stuff
vim.opt.spell = true
vim.opt.conceallevel = 1
vim.opt.concealcursor = "n"
vim.cmd("TSDisable highlight")
-- Semi-useful keybindings
vim.keymap.set("n", "<leader>o", "<cmd>VimtexView<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>ga", "<cmd>Gwrite<CR>")
vim.keymap.set("n", "<leader>gc", "<cmd>G commit<CR>")
