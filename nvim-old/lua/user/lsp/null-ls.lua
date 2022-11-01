local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with { extra_args = { "--single-quote", "--jsx-single-quote" } }, -- Prettier is an opinionated code formatter for javascript, javascriptreact , typescript , typescriptreact , vue, css, scss , less, html, json, jsonc , yaml, markdown, graphql, handlebars
    formatting.black.with { extra_args = { "--fast" } }, -- The uncompromising Python code formatter
    formatting.stylua, -- An opinionated code formatter for Lua
    -- formatting.rubocop, -- Ruby static code analyzer and formatter, based on the community Ruby style guide
  },
  on_attach = function(client)
    if client.server_capabilities.document_formatting then
      vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
      ]])
    end
  end,
}