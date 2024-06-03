vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc = "[P]roject [V]iew. Open file explorer. Equivalent of :Ex"})
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland 
vim.keymap.set({"n", "v"}, "<c-y>", [["*y]])
vim.keymap.set({"n", "v"}, "<c-p>", [["*p]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>n", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>p", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>h", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Terminal mode jam
-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {remap = true})
-- vim.keymap.set("n", "<leader>t", "<cmd>split | terminal<CR>i")
-- vim.keymap.set("t", "<leader>t", "<cmd>quit<CR>")

-- Correct spelling
vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", {noremap = true, desc = "Correct nearest mistake"})

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, {desc = "Shout out. Equivalent to :so"})

-- Escape and save
-- vim.keymap.set("n", "<C-_>", ':let @/ = ""<CR>', {silent = true, noremap = true})

vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>", {desc = "Accept change to the left"})
vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>", {desc = "Accept change to the right"})
