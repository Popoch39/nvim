return {
    'mhinz/vim-startify',
    event = 'VimEnter',
    config = function()
        local pokemon = require('pokemon')
        pokemon.setup({
            number = 'random',
            size = 'auto',
        })
        vim.g.startify_custom_header = pokemon.header()
    end,
    dependencies = { { 'ColaMint/pokemon.nvim' } }
}
