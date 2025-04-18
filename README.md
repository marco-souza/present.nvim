<h1 align="center">Markdown Slide Presenter for Neovim</h1>
<div>
  <h4 align="center">
    <a href="#install">Install</a> ·
    <a href="#usage">Usage</a>
  </h4>
</div>
<div align="center">
  <a href="https://github.com/marco-souza/plugin.nvim/releases/latest"
    ><img
      alt="Latest release"
      src="https://img.shields.io/github/v/release/marco-souza/present.nvim?style=for-the-badge&logo=starship&logoColor=D9E0EE&labelColor=302D41&&color=d9b3ff&include_prerelease&sort=semver"
  /></a>
  <a href="https://github.com/marco-souza/present.nvim/pulse"
    ><img
      alt="Last commit"
      src="https://img.shields.io/github/last-commit/marco-souza/present.nvim?style=for-the-badge&logo=github&logoColor=D9E0EE&labelColor=302D41&color=9fdf9f"
  /></a>
  <a href="https://github.com/neovim/neovim/releases/latest"
    ><img
      alt="Latest Neovim"
      src="https://img.shields.io/github/v/release/neovim/neovim?style=for-the-badge&logo=neovim&logoColor=D9E0EE&label=Neovim&labelColor=302D41&color=99d6ff&sort=semver"
  /></a>
  <a href="http://www.lua.org/"
    ><img
      alt="Made with Lua"
      src="https://img.shields.io/badge/Built%20with%20Lua-grey?style=for-the-badge&logo=lua&logoColor=D9E0EE&label=Lua&labelColor=302D41&color=b3b3ff"
  /></a>
  <!-- <a href="https://www.buymeacoffee.com/marco-souza" -->
  <!--   ><img -->
  <!--     alt="Buy me a coffee" -->
  <!--     src="https://img.shields.io/badge/Buy%20me%20a%20coffee-grey?style=for-the-badge&logo=buymeacoffee&logoColor=D9E0EE&label=Sponsor&labelColor=302D41&color=ffff99" -->
  <!-- /></a> -->
</div>
<hr />

# 📓 Markdown Slide Presenter for Neovim (`present.nvim`).

![image](https://github.com/user-attachments/assets/7b63763c-144e-4db6-87a5-834b8f8fb1cf)

## Features

- **Markdown to Slides**: Convert your Markdown files into slide presentations effortlessly.

## Install

```lua
-- Lazy plugin
{
  "marco-souza/present.nvim",
  cmd = "Present",
  config = true,
},
```

## Usage

Install it with your plugin manager, then add a keymap to the following command:

```sh
:Present show
```

