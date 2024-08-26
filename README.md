j## Norse.nvim

A modern Neovim configuration written in Lua, starring the beautiful
[Nord Theme](https://www.nordtheme.com/) color scheme. Backed by multiple cutting edge plugins such as Mason, Telescope, Treesitter, along with formatting, completion and language server protocol support.

![norse.nvim](https://github.com/lfv89/norse.nvim/blob/master/assets/nvim.jpg?raw=true)

![norse.nvim](https://github.com/lfv89/norse.nvim/blob/master/assets/nvim2.jpg?raw=true)

![norse.nvim](https://github.com/lfv89/norse.nvim/blob/master/assets/nvim3.jpg?raw=true)

![norse.nvim](https://github.com/lfv89/norse.nvim/blob/master/assets/go2.jpg?raw=true)

## Usage

Let's assume this repository was cloned into `~/foo/bar/norse.nvim`.

1. Create a symbolic link to `entry.lua` in your `~/.config/nvim` directory

```
ln -s ~/foo/bar/norse.nvim/vim/entry.lua ~/.config/nvim/init.lua
```

2. Change the hard-coded path in `entry.lua` line 20 to `~/foo/bar/norse.nvim`

3. Execute `:Lazy` and `:MasonInstall` to install the necessary plugins and binaries

## Observations

This is not a friendly configuration for beginners, it is meant for people who are already familiar with Neovim and want to take it to the next level. That being said, I will gladly help anyone who wants to learn more about it. Just open an issue and I will get back to you as soon as possible.
