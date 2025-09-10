# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NvChad-based Neovim configuration that uses the NvChad framework as a plugin. The main NvChad repository is imported as a dependency, and this configuration extends it with custom settings and plugins.

## Architecture

- **Entry Point**: `init.lua` - Sets up Lazy.nvim package manager, loads NvChad plugins, and initializes configuration
- **Main Configuration**: `lua/chadrc.lua` - Central configuration file that defines theme, UI settings, Mason packages, and module imports
- **Core Modules**:
  - `lua/options.lua` - Vim options and autocmds (extends nvchad.options)
  - `lua/mappings.lua` - Key mappings (extends nvchad.mappings)
  - `lua/configs/` - Configuration for specific plugins (LSP, formatters, etc.)
  - `lua/plugins/` - Custom plugin definitions and configurations

## Plugin Management

- Uses **Lazy.nvim** as the package manager
- NvChad is loaded as a plugin from the `v2.5` branch
- Custom plugins are defined in `lua/plugins/` directory
- Plugin configurations are in `lua/configs/` directory

## Key Components

- **Theme**: `flouromachine` (configured in chadrc.lua)
- **LSP Servers**: html, cssls, ts_ls, tailwindcss, emmet_ls (configured via Mason)
- **Mason Packages**: prettier, eslint_d, stylua, pylint, isort, black
- **Custom Features**:
  - Auto-dashboard on last buffer close
  - Relative line numbers enabled
  - Custom key mappings (jk for escape, ; for command mode)
  - Enhanced file explorer controls

## Development Commands

Since this is a Neovim configuration, development typically involves:
- Editing configuration files in `lua/` directory
- Testing changes by reloading Neovim (`:so` or restart)
- Managing plugins via Lazy.nvim (`:Lazy` command in Neovim)
- Updating NvChad: Update the NvChad plugin through Lazy.nvim

## Configuration Structure

The configuration follows NvChad's modular approach:
- Import NvChad base configurations with `require "nvchad.module"`
- Override or extend with local configurations
- Keep plugin definitions separate in `lua/plugins/`
- Store plugin-specific configs in `lua/configs/`
- Use Ref mcp to search for latest documentation