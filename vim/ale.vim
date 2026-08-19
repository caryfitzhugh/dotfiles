" setting it globally
let g:ale_linters = {
            \ 'python': ['ruff'],
            \ }

let g:ale_fixers = {
            \ 'python': ['ruff'],
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ }

"            yapf', 'isort'],
let g:ale_python_ruff_use_global = 1
let g:ale_fix_on_save = 1
