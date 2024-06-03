-- vim.keymap.set("n", "<leader>r", "<cmd>MagmaEvaluateOperator<CR>", {silent = true, expr = true})
vim.keymap.set("n", "<leader>rr", "<cmd>MagmaEvaluateLine<CR>", {silent = true})
vim.keymap.set("x", "<leader>r", "<cmd>MagmaEvaluateVisual<CR>", {silent = true})
vim.keymap.set("n", "<leader>rc", "<cmd>MagmaReevaluateCell<CR>", {silent = true})
vim.keymap.set("n", "<leader>rd", "<cmd>MagmaDelete<CR>", {silent = true})
vim.keymap.set("n", "<leader>ro", "<cmd>MagmaShowOutput<CR>", {silent = true})

vim.g.magma_automatically_open_output = false
vim.g.magma_image_provider = "ueberzug"

vim.cmd("MagmaInit python", {silent = true})
