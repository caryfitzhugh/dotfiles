# Vim configuration

## Setup

Run the repository setup script:

```sh
./setup_vim.sh
```

The script creates Vim's swap, backup, and undo directories, writes
`~/.vimrc` so that it sources this directory's `VIMRC`, installs Vim, installs
the plugins declared with vim-plug, and runs the Node.js setup.

To configure the source manually instead, put this in `~/.vimrc`:

```vim
source /path/to/dotfiles/vim/VIMRC
```

Then open Vim and run:

```vim
:PlugInstall
```

The map leader is a comma, so `<leader>rn` is typed as `,rn`.

## JavaScript and TypeScript support

`javascript.vim` configures CoC for these Vim filetypes:

- `javascript` for `.js`
- `javascriptreact` for `.jsx`
- `typescript` for `.ts`
- `typescriptreact` for `.tsx`

`VIMRC` loads the configuration with:

```vim
runtime javascript.vim
```

The mappings are buffer-local, so they only replace keys inside JavaScript,
TypeScript, JSX, and TSX buffers.

## CoC extensions

The configuration adds these extensions to `g:coc_global_extensions`. CoC
installs a missing extension automatically when Vim starts.

### `coc-tsserver`

Provides the TypeScript language service for JavaScript and TypeScript. It is
responsible for completion, type and syntax diagnostics, navigation, hover
documentation, symbol renaming, code actions, formatting, and import
organization.

The extension includes a TypeScript server, but it can use the TypeScript
version from the current project when configured to do so.

### `coc-eslint`

Runs ESLint and reports its warnings and errors through CoC. It also supplies
ESLint quick fixes and code actions.

ESLint and an ESLint configuration must exist in the project. A typical local
installation is:

```sh
npm install --save-dev eslint
```

`coc-eslint` prefers the project's ESLint installation, plugins, and
configuration. Without those, TypeScript diagnostics still work, but
project-specific ESLint rules do not.

## Diagnostics and linting

CoC displays diagnostic signs and highlights for JavaScript and TypeScript.
Virtual text is also enabled, which shows the diagnostic message beside the
affected code. By default, CoC shows that virtual text on the current line.

| Mapping | Action |
| --- | --- |
| `[g` | Jump to the previous diagnostic |
| `]g` | Jump to the next diagnostic |
| `,e` | Show details for the diagnostic under the cursor |
| `,qf` | Apply the preferred quick fix for the current diagnostic |

Use `:CocDiagnostics` to open all diagnostics for the current buffer in Vim's
location list.

## Code navigation

Place the cursor on a symbol before using these mappings:

| Mapping | Action |
| --- | --- |
| `gd` | Jump to the symbol's definition |
| `gy` | Jump to its type definition |
| `gi` | Jump to an implementation |
| `gr` | Find references to the symbol |
| `K` | Show hover documentation and type information |

Some navigation commands may open a list when there is more than one possible
destination.

## Refactoring and code actions

| Mapping | Action |
| --- | --- |
| `,rn` | Rename the symbol under the cursor across the project |
| `,ac` | Show the code actions available at the cursor |
| `,qf` | Apply the preferred quick fix on the current line |
| `,oi` | Organize imports in the current buffer |

Code actions can include adding missing imports, removing unused code,
applying ESLint fixes, or performing TypeScript refactors. The available
actions depend on the source code and project configuration.

## Completion

CoC requests completion suggestions automatically while typing. Press
`Ctrl-Space` in insert mode to request suggestions manually. Terminal Vim
represents `Ctrl-Space` internally as `<C-@>`, which is why the mapping uses
that notation in `javascript.vim`.

## Formatting

`,f` uses the formatter supplied by the active CoC language server.

- In visual mode, select some code and press `,f` to format that selection.
- In normal mode, `,f` acts as an operator and must be followed by a motion.
  For example, `,fap` formats the current paragraph.

This configuration does not install Prettier. The TypeScript language service
provides the default formatting behavior. A project can install and configure
a separate CoC formatter later if it needs Prettier-specific formatting.

## Troubleshooting

Useful commands inside Vim:

| Command | Purpose |
| --- | --- |
| `:CocList extensions` | Check whether `coc-tsserver` and `coc-eslint` are installed and enabled |
| `:CocInfo` | Show CoC services, workspace folders, and recent errors |
| `:CocDiagnostics` | List diagnostics for the current buffer |
| `:CocRestart` | Restart CoC and its language servers |
| `:CocCommand tsserver.restart` | Restart only the TypeScript server |
| `:CocCommand eslint.restart` | Restart only the ESLint server |
| `:set filetype?` | Confirm that Vim detected the expected JS, JSX, TS, or TSX filetype |

If ESLint produces no diagnostics, save the file, confirm that Vim was started
inside the project workspace, and check that the project contains both an
ESLint dependency and a supported ESLint configuration.
