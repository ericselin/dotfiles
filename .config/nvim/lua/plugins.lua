local use = require('packer').use
require('packer').startup(function()
  use 'shaunsingh/nord.nvim' -- Nord theme
  require('nord').set()
end)

