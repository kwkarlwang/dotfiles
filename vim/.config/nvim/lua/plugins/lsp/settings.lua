fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "󰅚", numhl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "󰌶", numhl = "DiagnosticSignHint" })
fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "DiagnosticSignInfo" })

local diagnostics_active = true
vim.keymap.set("n", "<leader>tD", function()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end)
-- update in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	update_in_insert = true,
	virtual_text = false,
})
