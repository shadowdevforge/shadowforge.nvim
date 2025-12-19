<div align="center">
 <img width="150" height="150" alt="ShadowForge" src="https://github.com/user-attachments/assets/bc836e58-646f-4c8d-8d2e-57a34818e52e" />
  
  <h1 align="center">ShadowForge.nvim</h1>
  
  <p align="center">
    <b>The Ultimate Neovim Experience.</b><br>
  </p>

  <p align="center">
     <img src="https://img.shields.io/badge/Neovim-94e2d5?style=for-the-badge&logo=neovim&logoColor=1e1e2e"/>
     <img src="https://img.shields.io/badge/Lua-b4befe?style=for-the-badge&logo=lua&logoColor=1e1e2e"/>
  </p>
  
  <p align="center">
    <a href="#-installation">Installation</a> •
    <a href="#-configuration">Configuration</a> •
    <a href="#-keybindings">Keybindings</a> •
    <a href="#-architecture">Architecture</a>
  </p>
  <a href="https://shadowdevforge.github.io/docs/project/ShadowForge" align="center">Detailed Documentation here</a>
</div>

---

## ⚡ Introduction

**ShadowForge.nvim** is not just a configuration; it is an Integrated Development Environment built on top of Neovim. It bridges the gap between the raw speed of Vim and the luxury of modern IDEs.

Unlike other distributions, ShadowForge prioritizes **Architecture**. It separates the "Core" (the engine) from the "User" (your config), ensuring that updates never break your personal settings.

<div align="center">
    [Full Documentation Here](https://shadowdevforge.github.io/ShadowForge.nvim)
</div>

### ✨ The Shadow Standard
*   **🚀 Blazing Fast:** Powered by `lazy.nvim` and `snacks.nvim` consolidation. Sub-30ms startup time.
*   **🧠 Hyper-Intelligent:** Replaces `nvim-cmp` with **`blink.cmp`** (Rust-based) for sub-millisecond autocompletion.
*   **🎨 Glassmorphic UI:** A heavily modified **Catppuccin** theme with transparency, window animations, and smooth scrolling.
*   **🛡️ Ironclad Stability:** Includes `ShadowDoctor` for diagnostics and `ShadowBackup` for instant snapshots of your config.
*   **🛠️ ShadowConfig:** Control the IDE via `lua/user/init.lua`. No complex Lua required.

---

| **Dashboard** |
|:---:|
| <img width="1876" height="980" alt="Dashboard" src="https://github.com/user-attachments/assets/ba06042f-ee62-4b17-9609-4832ba4aa9e9" /> |

| **ShadowDoctor** | **Coding Experience** | **Themery** 
|:---:|:---:|:---:|
|  <img width="1876" height="980" alt="ShadowDoctor" src="https://github.com/user-attachments/assets/be1f5e9f-2706-4e2d-81b4-ed33a2175f4e" /> | <img width="1876" height="980" alt="code" src="https://github.com/user-attachments/assets/c552e231-c78b-4b57-9c9c-5ebc72611b67" /> | <img width="1876" height="980" alt="themery" src="https://github.com/user-attachments/assets/e8a6a915-a97a-42b3-90fe-f8ac1e8a3228" /> |

---

## 📥 Installation

### 1. Prerequisites
*   **Neovim** >= 0.10.0
*   **Nerd Font** (JetBrains Mono Nerd Font recommended)
*   **Git**, **Ripgrep**, **Fd**, **NodeJS**, **GCC** (for Treesitter)

### 2. Clone the Forge
*Backup your existing config first!*

#### Linux / MacOS
```bash
git clone https://github.com/shadowdevforge/shadowforge.nvim ~/.config/nvim
```

#### Windows (PowerShell)
```powershell
git clone https://github.com/shadowdevforge/shadowforge.nvim $env:LOCALAPPDATA\nvim
```

### 3. Launch
Open Neovim. The **Bootstrap** process will start automatically.
```bash
nvim
```

---

## 🛠️ Management Tools

ShadowForge comes with built-in commands to keep your system healthy.

| Command | Description |
| :--- | :--- |
| `:ShadowDoctor` | Run a full system diagnostic check (Tools, Config, Health). |
| `:ShadowUpdate` | Pull latest core updates, sync plugins, and update parsers. |
| `:ShadowBackup` | Create a timestamped snapshot of your `lua/user` config. |

---

## ⚙️ Configuration
ShadowForge uses a **Zero-Conflict** architecture.

### 1. The Easy Way (`lua/user/init.lua`)
Toggle features using the simple configuration table.

```lua
return {
  editor = {
    relative_numbers = true,
    wrap = false,
  },
  ui = {
    transparency = true, -- Toggle glass effect
    animations = true,   -- Toggle smooth cursor
  },
  lsp = {
    servers = { "rust_analyzer", "ts_ls", "pyright", "gopls" }, -- Auto-install these
  },
}
```

### 2. The Power User Way (`lua/user/overrides.lua`)
Inject settings into any plugin or add new ones without editing the core.

```lua
return {
  -- Add a new plugin
  { "zbirenbaum/copilot.lua", cmd = "Copilot", event = "InsertEnter" },

  -- Modify an existing plugin
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = { window = { width = 40 } },
  },
}
```

---

## 🏗️ Architecture

```text
shadowforge.nvim/
├── init.lua                 # Bootstrapper & Performance Flags
├── lazy-lock.json           # Version Control Lockfile
├── lua/
│   ├── shadowforge/         # THE CORE (Read-Only)
│   │   ├── config.lua       # Configuration Engine
│   │   ├── core/            # Options, Keymaps, Autocmds
│   │   ├── health/          # Doctor & Backup Modules
│   │   └── modules/         # Plugin Specs
│   │       ├── coding/      # Blink, Conform, Pairs
│   │       ├── editor/      # Neo-tree, Telescope, Git
│   │       ├── lsp/         # LSPConfig, Mason
│   │       ├── treesitter/  # Treesitter, Context
│   │       └── ui/          # Themes, Dashboard, Lualine, Noice
│   └── user/                # YOUR CONFIG (Safe Zone)
│       ├── init.lua         # Feature Flags
│       ├── keymaps.lua      # Custom Bindings
│       └── overrides.lua    # Plugin Modifications
```

---

## ⌨️ Keybindings (Cheatsheet)
The `<Space>` key is your **Leader**.

| Context | Key | Action |
| :--- | :--- | :--- |
| **General** | `<Space> w` | Fast Save |
| | `<Space> qq` | Quit All |
| | `jj` | Exit Insert Mode |
| | `;` | Command Mode |
| **Files** | `<Space> e` | File Explorer (Neo-tree) |
| | `<Space> ff` | Find Files |
| | `<Space> fr` | Recent Files |
| | `<Space> fw` | Live Grep |
| **Explorer** | `H` (Shift+h) | Go Up (Parent Directory) |
| | `L` (Shift+l) | **Context Switch** (Zoom In / Change CWD) |
| | `l` | Open File / Expand Dir |
| | `h` | Collapse Dir |
| **UI** | `<Space> th` | Switch Theme (Themery) |
| | `<Space> sd` | Toggle Focus Mode (Dim) |
| | `<Space> un` | Dismiss Notifications |
| **Window** | `<C-h/j/k/l>` | Navigate Windows |
| | `<C-Arrow>` | Resize Windows |
| **Buffers** | `<S-h/l>` | Cycle Buffers |
| | `<Space> bd` | Close Buffer |
---
<div align="center">
   <p><a href="https://github.com/ShadowDevForge">Great time with shadowforge.nvim :)</a></p>
</div>

