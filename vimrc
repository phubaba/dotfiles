set nocompatible             "use vim, not vi
set nowrap                                         "do not wrap text
set showmatch                 "display matching braces
set hidden                                          " allow buffers to be hiden
set bg=dark
set ts=4
set ruler
syn on
 
set runtimepath+=~/.vim/bundle/Vundle.vim,~/.local/share/vim
let $GIT_SSL_NO_VERIFY='true'
 
 
" Begin Vundle plugin management
filetype off
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher' " speeds up ctrlp search considreably
"Plugin 'scrooloose/syntastic' " flake8-vim is much faster and easier to use
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'bkad/CamelCaseMotion'
Plugin 'vcscommand.vim'
Plugin 'hdima/python-syntax'
"Plugin 'hynek/vim-python-pep8-indent'
Plugin 'bling/vim-airline'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mileszs/ack.vim'
 
"Plugin 'Valloric/YouCompleteMe'
Plugin 'lokaltog/vim-easymotion'
Plugin 'AutoComplPop' " goto http://vim-scripts.org/vim/scripts.html
Plugin 'vim-scripts/Efficient-python-folding'
Plugin 'LargeFile'
Plugin 'andviro/flake8-vim'
"Plugin 'Townk/vim-autoclose'
Plugin 'Raimondi/delimitMate'
Plugin 'chazy/cscope_maps'
Plugin 'richsoni/vim-ecliptic'
"Plugin 'tomasr/molokai'
"Plugin 'ivalkeen/vim-ctrlp-tjump'
"Plugin 'fisadev/vim-ctrlp-cmdpalette'
"Plugin 'Keithbsmiley/investigate.vim'
call vundle#end()
 
 
" Get rid of Ex mode
nnoremap <S-Q> <Q>
 
"Go to end of line
inoremap <c-e> <esc>A
 
" set number
" set relativenumber
 
set term=xterm-256color
set ttytype=xterm-256color
 
 
"" needed for syntastic
"call pathogen#infect()
"let g:syntastic_python_checker = 'pyflakes'
"
"let g:syntastic_cpp_compiler = 'gnumake'
"let g:syntastic_cpp_compiler_options = ' -R MAKETARGET=rh5a64g4 MKDEPS=NO -j 8'
 
set noswapfile
 
colorscheme lucius
LuciusDark
 
"super tab
" let g:SuperTabRetainCompletionDuration='completion'
let g:AutoClosePumvisible = {"ENTER": "<C-Y>", "ESC": "<ESC>"}
 
let g:LargeFile= 50            " in megabytes
 
 
" adds a vertical line at 100 to visually keep lines by 100
hi ColorColumn ctermbg=237 guibg=#3a3a3a
set colorcolumn=100
 
let mapleader=';'      " Change leader to something easier to reach
 
" auto preview http://www.vim.org/scripts/script.php?script_id=2228
let g:AutoPreview_enabled =0
 
" make you could press F5 key to enable or disable the preview window, you can also set to other favorite hotkey here
nnoremap <F5> :AutoPreviewToggle<CR>
inoremap <F5> <ESC>:AutoPreviewToggle<CR>i
 
" set the time(ms) break to refresh the preview window, I recommend 500ms~1000ms with good experience
set updatetime=500
 
"needs to be done to get more colors
set t_Co=256
 
" this avoids having to do "+ when copying to and from buffers
" set clipboard=unnamed
 
au FileChangedShell * echo "Warning: File changed on disk"
 
" clears last search highlighting when you press shift-H
nnoremap <S-H> :noh<CR>
 
" searching
set ignorecase                   "ignore case when searching
set smartcase                    "retain case when pattern has uppercase
set infercase                      "adjust case for keyword completion
set incsearch                      "incremental searches
set hlsearch                        "highlight searches
set wrapscan                     "do wrap searches
 
" see http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
" set foldmethod=syntax
let g:pydiction_location = '~/.vim/ftplugin/pydiction/complete-dict'
 
"status bar with more info
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2    "always show status bar even if only one buffer open
 
let iswindows = has('win16') || has('win32') || has('win64')
if iswindows
                let Tlist_Ctags_Cmd = 'C:/Ctags58/ctags'
else
                let Tlist_Ctags_Cmd = '/auto/csmodeldata/foopen/AMD64/bin/ctags'
endif
 
let g:UltiSnipsJumpForwardTrigger="<tab>"                                      
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
 
"let Tlist_Compact_Format=1
"let Tlist_Process_File_Always=1
"let Tlist_Show_One_File=1
"let Tlist_Sort_Type='name'
"let g:tlist_python_settings = 'python;v:variable;c:class;m:member;f:function;i:imports'
"" Update taglist on write
"au BufWritePost * TlistUpdate
"" Tag List Toggle
"nmap <silent> <leader>tags :TlistToggle<CR>
"map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
 
function! CleanTags()
                                if exists('g:ctags_tempfiles')
                                                                if !empty(g:ctags_tempfiles)
                                                                                                for tempfile in g:ctags_tempfiles
                                                                                                                                exe 'silent set tags-=' . tempfile
                                                                                                                                call delete(tempfile)
                                                                                                endfor
                                                                endif
                                endif
endfunction
 
function! MakeTags()
                                let iswindows = has('win16') || has('win32') || has('win64')
                                let slash = iswindows ? '\' : '/'
                                let fname = fnamemodify(bufname('%'), ':p')
                                let fdir = fnamemodify(bufname('%'), ':p:h')
                                let ftype = getbufvar('%', '&filetype')
 
                                if !exists('g:ctags_tempfiles')
                                                                let g:ctags_tempfiles = []
                                endif
 
                                let tempfile = tempname()
                                call add(g:ctags_tempfiles, tempfile)
 
                                if !exists('g:ctags_executable')
                                                                if iswindows
                                                                                                let g:ctags_executable = 'C:/Ctags58/ctags'
                                                                else
                                                                                                let g:ctags_executable = '/auto/csmodeldata/foopen/AMD64/bin/ctags'
                                                                endif
                                endif
 
                                let tagcmd = g:ctags_executable . ' -f ' . tempfile
                                let tagopts = ' --recurse=yes --sort=foldcase ' . fdir
 
                                let output = system(tagcmd . tagopts)
 
                                if output != ''
                                                                echohl WarningMsg
                                                                echomsg tagcmd
                                                                echomsg output
                                                                echohl None
                                else
                                                                exe 'silent set tags+=' . tempfile
                                endif
endfunction
 
autocmd VimLeave * call CleanTags()
command! -nargs=0 MakeTags :call MakeTags()
 
" === editing mappings
 
" Make tab indent code in visual mode
vmap <tab> >gv
vmap <s-tab> <gv
 
"indentation, etc.
set cindent comments=:# cinkeys-=0#
set formatoptions=croql
set autoindent
set smartindent
set smarttab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab      " Use spaces rather than tabs
 
" flake8
let g:PyFlakeCheckers = 'pep8'
let g:PyFlakeDisabledMessages = 'E501,C0103,C0301'
let g:PyFlakeMaxLineLength = 150
let g:PyFlakeRangeCommand = 'Q'
let g:PyFlakeCWindow=0
 
"pastetoggle for disabling auto indentation
set pastetoggle=<F2>
 
"completion settings
set complete=.,w,b,u,t
set completeopt=menuone,longest,preview
 
" Erase any trailing spaces
nmap <silent> <Leader>trim :%s/\s\+$//g<CR>
 
"Syntax highlighting
syntax on            " Enable syntax highlighting
filetype on          " Enable filetype detection
filetype indent on   " Enable filetype-specific indenting
filetype plugin on   " Enable filetype-specific plugins
let python_highlight_all=1
 
nmap <C-x> :bd <cr>
nmap <Space> <PageDown>
 
" Abbreviations
function EatChar(p)
                let c = nr2char(getchar(0))
                return (c =~ a:p) ? '' : c
endfunction
 
" Completions
"function CleverTab()
"              if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$'
"                              return "\<Tab>"
"              else
"                              return "\<C-N>"
"endfunction
"inoremap <Tab> <C-R>=CleverTab()<CR>
 
" Resize windows
nmap <S-e> :resize +15<CR>
nmap <S-b> :resize -15<CR>
nmap <C-e> :vertical resize +15<CR>
nmap <C-b> :vertical resize -15<CR>
" = VCS OPTIONS =
 
let VCSCommandDeleteOnHide = 1
 
augroup VCSCommand
    au User VCSBufferCreated set bufhidden=wipe
augroup END
 
 
" vim scope options
if has("cscope")
    set cscopeprg=/auto/cnvtvws/vim/7.3/bin/cscope
    set cscopetagorder=0
    set cscopetag
    set nocscopeverbose
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif
 
" = VIMWIKI OPTIONS =
 
 
let g:vimwiki_hl_cb_checked=1 " Comment out checked items
let g:vimwiki_use_mouse=0 " Toggle mouse to navigate
let g:vimwiki_hl_headers=1
let g:vimwiki_camel_case=1
let g:vimwiki_folding=1
let g:vimwiki_fold_lists=1
let g:vimwiki_table_auto_fmt=0 " Allow tab complete by removing tab table mappings
au BufNewFile,BufRead *.wiki set tw=79
 
noremap <silent> <leader>wj :VimwikiDiaryNextDay<CR>
noremap <silent> <leader>wk :VimwikiDiaryPrevDay<CR>
 
let wiki = {}
let wiki.path = '~/wiki/'
let wiki.path_html = '~/wiki/html/'
let wiki.index = 'Index'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'c#': 'cs', 'C#': 'cs', 'sql': 'sql'}
let wiki.maxhi = 1
let wiki_info = {}
let wiki_info.path = '/Volumes/info/'
let wiki_info.path_html = '/Volumes/info/html/'
let wiki_info.index = 'Index'
let wiki_info.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'c#': 'cs', 'C#': 'cs', 'sql': 'sql'}
let wiki_info.maxhi = 1
let g:vimwiki_list = [wiki, wiki_info]
 
function! CheckCompleteAndTimestamp()
    normal ^
    normal f]
    let datetime=strftime('%Y-%m-%d')
    exe "normal a (" . datetime . ")"
    exe "VimwikiToggleListItem"
    normal ^
endfun
noremap <silent> <leader>td :call CheckCompleteAndTimestamp()<CR>
 
"" ctags path
let g:ctags_path = "./tags"
 
" = ctrl p arguments"
"let g:ctrlp_custom_ignore = '\v\~$|\.o$|\.so$|rh5a64g4|.obj$|\.dll$|\.pyc$|\.pyo$|\.exe$|\.bak$|\.swp$|\.lib$|\.exp$|\.nfs.*$|\.pyd$|\.swo$|\.swn$|\.zip$|\.json$|\.html$|\.bba$|\.log$|\.xml$|\.pyfixed$|\.pdf$|\.h5$|\.xls$|\.sh$|\.tex$|\.txt$|\.lock$|\.dat'
let g:ctrlp_user_command = "find %s -type f | egrep -v '/\.(git|hg|svn)|solr|tmp/' | egrep -v '\.(pyc|png|exe|jpg|gif|jar|class|swp|swo|log|gitkep|keepme|so|o)$'"
 
let g:ctrlp_show_hidden=0
let g:ctrlp_switch_buffer=1
let g:ctrlp_match_window='max:10,results:100'
let g:ctrlp_use_caching=1
let g:ctrlp_root_markers=['cscope.out', 'tags']
let g:ctrlp_extensions=['buffertag']
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_buftag_ctags_bin='/auto/cnvtvws/vim/current/bin/ctags'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
 
"DirDiff
"let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,*.o,*.a,*.so,*.pyc,*.svn*,*tmp*"
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,*.o,*.a,*.so,*.pyc,*.svn"
let g:DirDiffIgnore = "Id:,Revision:,Date:"
let g:DirDiffSort = 1
let g:DirDiffWindowSize = 14
let g:DirDiffInteractive = 0
let g:DirDiffIgnoreCase = 0
 
nmap <F3> :diffget<CR>]czz
nmap <F7> [czz
nmap <F8> ]czz
 
" Next and Previous error (using Make)
map <C-n> :cn<CR>
map <C-p> :cp<CR>
 
imap <C-j> <Esc><C-W>j<C-W>_:set foldmethod=manual<CR>
imap <C-k> <Esc><C-W>k<C-W>_:set foldmethod=manual<CR>
map <C-j> <C-W>j<C-W>_:set foldmethod=manual<CR>
map <C-k> <C-W>k<C-W>_:set foldmethod=manual<CR>
 
nmap <F9> :set nowrap<CR>
nmap <F10> :set wrap<CR>
 
 
" When bringing up a browse dialog, start in the current buffer's directory
set browsedir=buffer
 
set backspace=2
set lazyredraw
set noequalalways
set wmh=0
 
" makes it so you can tab complete
set wildmenu
set wildmode=longest:list
 
vmap Q gq
 
vmap <C-j> /^[^a-zA-Z0-9]*$<CR>k
vmap <C-k> ?^[^a-zA-Z0-9]*$<CR>j
 
" Function to change to the current directory of the current file when called
"function! CHANGE_CURR_DIR()
"    if (strlen(@%)!=0)
"        exec "cd " . expand("%:p:h")
"    endif
"endfunction
"
"autocmd BufEnter * call CHANGE_CURR_DIR()
 
function! RunPyflakes(...)
  if (a:0 == 0)
    let arg = "%"
  else
    let arg = join(a:000, ' ')
  endif
  let cmd = "setlocal makeprg=pyflakes\\ " . arg . '\\\\|grep\ -v\ \"baseSite\"'
  exe cmd
  make
  cw
endfunction
nmap <buffer>  <F11>   :call RunPyflakes()<CR>
command! -nargs=* -complete=file Pyflakes call RunPyflakes(<f-args>)
command -nargs=1 Security :py LookupSecurity(<args>)
command -nargs=1 Issuer :py LookupIssuer(<args>)
 
 
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction
 
" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&
 
  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')
 
  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save
 
  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)
 
  return escaped_selection
endfunction
 
" Start the find and replace command across the entire file
vmap <leader>z <Esc>:%s/<c-r>=GetVisual()<cr>/
 
" related to .mma syntax vim-mathematica
let g:mma_candy = 1