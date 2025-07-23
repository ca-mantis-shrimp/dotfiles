# AGENTS.md - Coding Agent Guidelines

## Build/Test Commands
- `chezmoi apply` - Apply configuration changes to system
- `chezmoi diff` - Show differences between source and target state
- `chezmoi doctor` - Check system for potential problems
- `:Neorg tangle current-file` - Generate config files from literate_config/*.norg
- `python scripts/generate_uuid_v7.py` - Generate UUID v7 (alias: `idv7`)

## Literate Configuration System
This repository uses Neorg for literate programming. Configuration files are generated from documentation in the `literate_config/` folder.

Workflow:
1. Check `literate_config/` folder for context and reasoning
2. Edit `.norg` files (not generated config files)
3. Look for `tangle:` directive in file metadata to see output path
4. Use `:Neorg tangle current-file` to generate configs
5. Run `chezmoi diff` to validate changes
6. Run `chezmoi apply` to deploy changes

## Code Style Guidelines

### Fennel (.fnl files)
- Use kebab-case for function names and variables
- Prefix global vim API calls with `_G.vim`
- Use descriptive function parameter names
- Group related autocmds and keymaps logically

### Lua (.lua files)
- Follow Neovim Lua conventions
- Use snake_case for variables and functions
- Prefer local variables over globals
- Use require() for module imports

### Python (.py files)
- Follow PEP 8 style guidelines
- Use snake_case for functions and variables
- Include docstrings for functions
- Use type hints where appropriate

### Configuration Files
- Use consistent indentation (2 spaces for TOML/YAML)
- Group related settings together
- Comment complex configurations
- Use template variables for environment-specific values

This is a chezmoi-managed dotfiles repository with literate configuration documentation.