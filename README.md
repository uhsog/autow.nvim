# 💾 autow.nvim

**A lightweight, no-nonsense autosave plugin for Neovim.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Neovim](https://img.shields.io/badge/Neovim-0.8+-blue.svg)](https://neovim.io/)

Stop worrying about `:w` every two seconds. `autow.nvim` automatically saves your changes whenever you leave Insert mode, so you can focus on what actually matters—writing code.

## ✨ Features

- 🚀 **Blazing Fast**: Written 100% in Lua. Zero overhead.
- 🛠️ **Configurable**: Filter by filetypes or exclude specific filenames.
- 🔄 **Toggleable**: Need to disable it temporarily? Just run `:AutowToggle`.
- 🧩 **Smart**: Won't try to save read-only or scratch buffers.

## 📦 Installation

Use your favorite plugin manager.

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'uhsog/autow.nvim',
  config = function()
    require('autow').setup({
      -- your config here (optional)
    })
  end
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'uhsog/autow.nvim',
  config = function()
    require('autow').setup()
  end
}
```

## ⚙️ Configuration

`autow.nvim` works great out of the box, but you can tweak it to your liking:

```lua
require('autow').setup({
  enabled = true,                        -- Enable on startup (default: true)
  filetypes = { "lua", "python" },      -- Only autosave these filetypes (default: {} for all)
  exclude_filenames = { "secrets.txt" }, -- Skip these files (default: {})
})
```

## 🎮 Commands

- `:AutowToggle` - Toggle the autosave functionality ON/OFF.

## 📜 License

MIT. Feel free to use it, hack it, and make it yours!

---
*Built with ❤️ for the Neovim community.*
