" setting it globally
let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \ 'python': ['ruff'],
            \ 'c': ['clangtidy'],
            \ 'cpp': ['clangtidy'],
            \ }
let g:ale_c_build_dir_names = ['build']
let g:ale_fixers = {
            \ 'python': ['ruff'],
            \ 'c': ['clang-format', 'remove_trailing_lines', 'trim_whitespace'],
            \ 'cpp': ['clang-format', 'remove_trailing_lines', 'trim_whitespace'],
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ }
let g:ale_python_ruff_use_global = 1
let g:ale_fix_on_save = 1
