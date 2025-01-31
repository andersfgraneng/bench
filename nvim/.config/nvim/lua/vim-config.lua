vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.g.mapleader = " "

vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>df", "<Cmd>lua require'jdtls'.test_class()<CR>") -- nnoremap  <Cmd>lua require'jdtls'.test_class()<CR>
vim.keymap.set("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>") -- nnoremap  <Cmd>lua require'jdtls'.test_nearest_method()<CR>
vim.keymap.set("n", "<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>") -- nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
vim.keymap.set("n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>") -- nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vim.keymap.set("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>") -- vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
vim.keymap.set("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>") -- nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
vim.keymap.set("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>") -- vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vim.keymap.set("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>") -- vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
