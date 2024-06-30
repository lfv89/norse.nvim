## norse.nvim

A modern neovim configuration written in Lua, starring the beautiful
[Nord Theme](https://www.nordtheme.com/) color scheme and backed by multiple cutting edge plugins
such as Mason, Telescope, Treesitter, along with formatting, completion and language server protocol support.

![norse.nvim](https://github.com/lfv89/norse.nvim/blob/master/assets/nvim.jpg?raw=true)

![norse.nvim](https://github.com/lfv89/norse.nvim/blob/master/assets/nvim2.jpg?raw=true)

![norse.nvim](https://github.com/lfv89/norse.nvim/blob/master/assets/nvim3.jpg?raw=true)

![norse.nvim](https://github.com/lfv89/norse.nvim/blob/master/assets/go1.jpg?raw=true)

## Usage

Let's assume this repository was cloned into `~/foo/bar/norse.nvim`.

1. Create a symbolic link to `entry.lua` in your `~/.config/nvim` directory

```
ln -s ~/foo/bar/norse.nvim/vim/entry.lua ~/.config/nvim/init.lua
```

2. Change the hard-coded path in `entry.lua` line 20 to `~/foo/bar/norse.nvim`
