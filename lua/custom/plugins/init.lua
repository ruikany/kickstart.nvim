-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup {
        adapters = {
          gemini = function()
            return require('codecompanion.adapters').extend('gemini', {
              env = {
                api_key = os.getenv 'GEMINI_API_KEY',
              },
              schema = {
                model = {
                  -- Explicitly use Flash (Free Tier friendly)
                  default = 'gemini-1.5-flash',
                },
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = 'gemini' },
          inline = { adapter = 'gemini' },
          agent = { adapter = 'gemini' },
        },
      }
      -- Keymaps for the sidebar and inline actions
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>CodeCompanionChat Toggle<cr>', { desc = '[C]ode [A]ssistant Chat' })
      vim.keymap.set({ 'n', 'v' }, '<leader>ce', '<cmd>CodeCompanionActions<cr>', { desc = '[C]ode [E]dit Actions' })
    end,
  },
}
