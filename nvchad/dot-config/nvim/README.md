# NvChad Configuration

## Plugins

### Core Framework

- **NvChad (v2.5)** - Main Neovim framework
- **Lazy.nvim** - Plugin manager
- **Theme**: kanagawa with custom highlight overrides

### Development Tools

- **lazygit** - Git integration within Neovim
- **linting** - Code linting support
- **trouble** - Pretty diagnostics viewer
- **todo-comment** - Highlight and navigate TODO comments

### UI/UX Enhancements

- **dressing** - Better UI for vim.ui.select and vim.ui.input
- **snacks** - Collection of useful UI enhancements
- **auto-session** - Automatic session management
- **snipe** - Enhanced buffer and file navigation

### Text Editing

- **mini-ai** - Extended and customizable text objects
- **surround** - Manipulate surroundings (brackets, quotes, etc.)

### AI Integration

- **ollama** - Local LLM integration for AI assistance

### LSP & Formatting (via Mason)

- **Language Servers**: html, cssls, ts_ls, tailwindcss, emmet_ls
- **Formatters/Linters**: prettier, eslint_d, stylua, pylint, isort, black

## Key Features

- Custom telescope configuration with hidden file support
- Enhanced file tree controls with resize mappings
- Auto-dashboard on last buffer close
- Relative line numbers enabled
- Custom key mappings (jk for escape, ; for command mode)

## Plugin Usage Examples

### Mini.ai (Enhanced Text Objects)

Mini.ai extends Neovim's built-in text objects with additional functionality:

**Basic Usage:**
- `daw` - Delete around word
- `diw` - Delete inside word  
- `da)` - Delete around parentheses
- `di)` - Delete inside parentheses
- `da"` - Delete around quotes
- `di"` - Delete inside quotes

**Advanced Text Objects:**
- `daf` - Delete around function call
- `dif` - Delete inside function call
- `dat` - Delete around tag (HTML/XML)
- `dit` - Delete inside tag
- `daa` - Delete around argument
- `dia` - Delete inside argument

**Next/Last Variants:**
- `dan` - Delete around next text object
- `dal` - Delete around last text object
- `din` - Delete inside next text object
- `dil` - Delete inside last text object

### Substitute Plugin

The substitute plugin provides enhanced text replacement capabilities:

**Key Mappings:**
- `s{motion}` - Substitute text with motion (e.g., `siw` substitutes inner word)
- `ss` - Substitute entire line
- `S` - Substitute from cursor to end of line
- `s` (in visual mode) - Substitute selected text

**Usage Examples:**
1. `siw` - Substitute the word under cursor
2. `s$` - Substitute from cursor to end of line  
3. Visual select text, then `s` - Substitute selected text
4. `ss` - Substitute the entire current line

### Treesitter Incremental Selection

Treesitter provides syntax-aware text selection using the abstract syntax tree:

**Key Mappings:**
- `<C-space>` - Initialize selection or expand to next syntax node
- `<Backspace>` - Shrink selection to previous syntax node

**Usage Examples:**
1. Place cursor on a variable → `<C-space>` selects the variable
2. `<C-space>` again → expands to encompassing expression
3. `<C-space>` again → expands to statement/block
4. `<Backspace>` → shrinks selection back down the syntax tree

**Practical Workflow:**
- Start with cursor anywhere in code
- Use `<C-space>` to intelligently select increasingly larger syntax elements
- Use `<Backspace>` to fine-tune selection size
- Works with any operation (delete, yank, change, etc.)

**Supported Languages:**
json, javascript, typescript, tsx, yaml, html, css, markdown, svelte, bash, lua, vim, dockerfile

## LSP Mappings

The following LSP (Language Server Protocol) keybindings are available when working with supported languages:

**Navigation:**
- `gd` - Go to definition (jump to where function/variable is defined)
- `gD` - Go to declaration
- `gr` - Go to references (find all uses of symbol)
- `gi` - Go to implementation

**Information:**
- `K` - Show hover documentation
- `<leader>sh` - Show signature help

**Code Actions:**
- `<leader>ca` - Code actions
- `<leader>ra` - Rename symbol

**Diagnostics:**
- `]d` - Go to next diagnostic
- `[d` - Go to previous diagnostic
- `<leader>q` - Open diagnostic quickfix list

These mappings work automatically when an LSP server is attached to the current buffer. LSP servers are configured via Mason for supported languages (html, css, typescript, tailwindcss, emmet).

## Todo Comments

The todo-comment plugin highlights and provides navigation for TODO, FIXME, HACK, and other comment annotations in your code.

**Highlighted Keywords:**
- `TODO:` - General todo items
- `FIXME:` - Things that need fixing
- `HACK:` - Hacky solutions that need cleanup
- `WARN:` - Warning notes
- `PERF:` - Performance related notes
- `NOTE:` - General notes
- `TEST:` - Testing related comments

**Navigation:**
- `]t` - Jump to next todo comment
- `[t` - Jump to previous todo comment
- `<leader>ft` - Search all todo comments with Telescope

**Usage Examples:**
```lua
-- TODO: implement this feature
-- FIXME: this breaks on edge case
-- HACK: temporary workaround
-- NOTE: important implementation detail
```

The plugin automatically highlights these comments with distinct colors and integrates with Telescope for project-wide todo searching.

## Quickfix List

The quickfix list is a powerful feature for navigating through multiple file locations efficiently.

**Navigation Commands:**
- `:cnext` / `:cn` - Go to next item
- `:cprev` / `:cp` - Go to previous item
- `:cfirst` - Go to first item
- `:clast` - Go to last item
- `:cc N` - Go to item number N

**Opening/Closing:**
- `:copen` - Open quickfix window
- `:cclose` - Close quickfix window
- `<CR>` - Jump to location (when in quickfix window)

**Common Use Cases:**

*LSP Diagnostics:*
- `<leader>q` - Populate with current buffer diagnostics
- Navigate through all errors/warnings in your project

*Search Results:*
- `:vimgrep /pattern/g **/*.js` - Search and populate quickfix
- `:grep pattern *.lua` - Use external grep

*Compiler Errors:*
- `:make` - Run build and capture errors
- Jump through compilation issues

*Todo Comments:*
- Use telescope to search todos, then send to quickfix
- Navigate through all TODO/FIXME items

*Find and Replace:*
- Use `:cfdo %s/old/new/g | update` to replace across all files in quickfix

**Advanced Features:**
- `:chistory` - See previous quickfix lists
- `:colder` / `:cnewer` - Navigate quickfix history
- Quickfix persists across sessions
- Many plugins populate quickfix automatically (LSP, linters, search tools)
