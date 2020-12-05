set nocompatible              " be iMproved, required
"plugins{
so ~/.vim/plugins.vim
"}
set backspace=indent,eol,start
" General {
let $LANG='en'
filetype plugin indent on
set sw=4 ts=4 sts=4 et tw=80
syntax enable
set mouse=a                         " Automatically enable mouse usage
set mousehide                       " Hide the mouse cursor while typing
scriptencoding utf-8

set clipboard=unnamed
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set smartindent

 "}
"Vim UI{
if has('gui_running')
    set background=dark
    colorscheme spring-night
    set guioptions-=m
    set guioptions-=T
else
    colorscheme spring-night
endif
set tabpagemax=15                   " Only show 15 tabs
set showmode                        " Display the current mode
highlight clear SignColumn          " SignColumn should match background
"set cursorcolumn                    " Highlight current col
set cursorline                      " Highlight current line<
set number " show line number
set linespace=0                     " Gui Vim line-height
set showmatch                   " Show matching brackets/parenthesis
set hlsearch                        " Hightline search terms
set incsearch                       " Find as you type search

   if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

"}
"GUI Setting{
set guioptions-=l                   "remove lefthand scrollbar(alway)
set guioptions-=L                   "remove lefthand scrollbar(vertically)
set guioptions-=r                   "remove righthand scrollbar(alwary)
set guioptions-=R                   "remove righthand scrollbar(vertically)

set guioptions-=e                   "remove gui Tab
set guifont=Inconsolata\ for\ Powerline:h14
"}
" Formatting {
set splitbelow
set splitright

"}
"--------------Key Mapping---------"
let mapleader = ","
"Make it easy to edit vimrc file;
nmap <leader>ev :tabedit $MYVIMRC<CR>
nmap <silent> <Leader>/  :nohlsearch<CR>

"Split Moving
nmap <C-J> <C-W><C-J> 
nmap <C-K> <C-W><C-K> 
nmap <C-H> <C-W><C-H> 
nmap <C-L> <C-W><C-L> 

"Plugins{
    " ctrlp {
        if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <silent> <C-p> :CtrlP<CR>
            nnoremap <silent> <C-r> :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if exists("g:ctrlp_user_command")
                unlet g:ctrlp_user_command
            endif
            if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
                " CtrlP extensions
                let g:ctrlp_extensions = ['funky']

                "funky
                nnoremap <Leader>fu :CtrlPFunky<Cr>
            endif
        endif
    "}
    " NerdTree {
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
            nmap <C-T> :NERDTreeToggle<CR>
            "nmap <D-2> :NERDTreeFind<CR>


            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }
    " Ack {
       let g:ackprg = 'ag --vimgrep'
    "}
    " Airline {
        if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
                let g:airline_theme = 'spring_night'                
        endif
      let g:airline#extensions#tabline#enabled = 1
      
    " }
    " vim-airline {
    
    if isdirectory(expand("~/.vim/bundle/vim-airline"))
     let g:airline_theme='spring_night'
     let g:airline_powerline_fonts = 1
     let g:Powerline_symbols='fancy'
     let g:airline#extensions#tabline#enabled=1
     let g:airline#extensions#tabline#buffer_idx_mode = 1
     let g:airline#extensions#tabline#buffer_nr_show = 1
     let g:airline#extensions#tabline#buffer_nr_format = '%s:'
     let g:airline#extensions#tabline#fnamemod = ':t'
     let g:airline#extensions#tabline#fnamecollapse = 1
     let g:airline#extensions#tabline#fnametruncate = 0
     let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
     let g:airline#extensions#default#section_truncate_width = {
                 \ 'b': 79,
                 \ 'x': 60,
                 \ 'y': 88,
                 \ 'z': 45,
                 \ 'warning': 80,
                 \ 'error': 80,
                 \ }
     let g:airline#extensions#default#layout = [
                 \ [ 'a', 'error', 'warning', 'b', 'c' ],
                 \ [ 'x', 'y', 'z' ]
                 \ ]

     " Distinct background color is enough to discriminate the warning and
     " error information.
     let g:airline#extensions#ale#error_symbol = '•'
     let g:airline#extensions#ale#warning_symbol = '•'
    endif
" }
" ale {
    let g:ale_linters = {
                \   'sh' : ['shellcheck'],
                \   'html' : ['tidy'],
                \   'python' : ['flake8'],
                \   'markdown' : ['mdl'],
                \   'javascript' : ['eslint'],
                \}
    let g:ale_set_highlights = 0
    " If emoji not loaded, use default sign
    try
        let g:ale_sign_error = emoji#for('boom')
        let g:ale_sign_warning = emoji#for('small_orange_diamond')
    catch
        " Use same sign and distinguish error and warning via different colors.
        let g:ale_sign_error = '•'
        let g:ale_sign_warning = '•'
    endtry
    let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'
    let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

    " For a more fancy ale statusline
    function! ALEGetError()
        let l:res = ale#statusline#Status()
        if l:res ==# 'OK'
            return ''
        else
            let l:e_w = split(l:res)
            if len(l:e_w) == 2 || match(l:e_w, 'E') > -1
                return ' •' . matchstr(l:e_w[0], '\d\+') .' '
            endif
        endif
    endfunction

    function! ALEGetWarning()
        let l:res = ale#statusline#Status()
        if l:res ==# 'OK'
            return ''
        else
            let l:e_w = split(l:res)
            if len(l:e_w) == 2
                return ' •' . matchstr(l:e_w[1], '\d\+')
            elseif match(l:e_w, 'W') > -1
                return ' •' . matchstr(l:e_w[0], '\d\+')
            endif
        endif
    endfunction

        let g:ale_echo_msg_error_str = '✹ Error'
        let g:ale_echo_msg_warning_str = '⚠ Warning'

    nmap <Leader>en <Plug>(ale_next)
    nmap <Leader>ep <Plug>(ale_previous)
" }
" vim-indent-guides {
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 0
    nnoremap <Leader>ti :IndentGuidesToggle<CR>
" }
" YouCompleteMe {
"    let g:ycm_error_symbol='✖'
"    let g:ycm_warning_symbol='⚠ '
"    let g:ycm_cache_omnifunc=0
"    let g:ycm_complete_in_strings=1
"    let g:ycm_complete_in_comments=1
"    let g:ycm_seed_identifiers_with_syntax=1
"    let g:ycm_min_num_of_chars_for_completion=2
"    " ycm_path_to_python_interpreter is important!
""    let g:ycm_path_to_python_interpreter='python'
"    let g:ycm_python_binary_path = 'python3'
"    let g:ycm_autoclose_preview_window_after_completion = 1
"    let g:ycm_collect_identifiers_from_comments_and_strings=0
"    let g:ycm_global_ycm_extra_conf = fnamemodify(expand('<sfile>'), ':h') . '/global_conf.py'
"    let g:ycm_semantic_triggers =  {
"                \   'c' : ['->', '.'],
"                \   'objc' : ['->', '.'],
"                \   'ocaml' : ['.', '#'],
"                \   'cpp,objcpp' : ['->', '.', '::'],
"                \   'perl' : ['->'],
"                \   'php' : ['->', '::', '(', 'use ', 'namespace ', '\'],
"                \   'cs,java,typescript,d,python,perl6,scala,vb,elixir,go' : ['.', 're!(?=[a-zA-Z]{3,4})'],
"                \   'html': ['<', '"', '</', ' '],
"                \   'vim' : ['re![_a-za-z]+[_\w]*\.'],
"                \   'ruby' : ['.', '::'],
"                \   'lua' : ['.', ':'],
"                \   'erlang' : [':'],
"                \   'haskell' : ['.', 're!.'],
"                \   'scss,css': [ 're!^\s{2,4}', 're!:\s+' ],
"                \ }
"    let g:ycm_filetype_blacklist={
"                \   'tagbar' : 1,
"                \   'nerdtree' : 1,
"                \   'markdown' : 1,
"                \   'unite' : 1,
"                \   'text' : 1,
"                \   'csv' : 1,
"                \}
"    " let g:ycm_key_invoke_completion='<M-;>'
"let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
"}
" UltiSnips {
let g:UltiSnipsExpandTrigger = "<c-n>"
let g:UltiSnipsJumpForwardTrigger = "<c-n>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
" }
" completor {
let g:completor_python_binary = "~/anaconda3/bin/python3.6"
inoremap <expr> <Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
"}
"--------------Auto-Comands---------"
"Automatically source the Vimrc file
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END
