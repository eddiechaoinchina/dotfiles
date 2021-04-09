" Author: Will Chao <nerdzzh@gmail.com>
" Filename: _vimrc
" Last Change: 2021/4/9 22:19:32 +0800
" Brief: My _vimrc File

" Preamble -------------------------------------- {{{

" Make sure "node", "python", "gcc" are installed to make certain mappings work
" properly. The version and bits of "python" must be compatible with "vim". When
" this script is written, a possible solution would be "anaconda3-5.3.0" and
" "gvim-8.1.2424".
"
" It is weird that "apt-get" gives me a version without clipboard support, so
" better install "vim-gtk" on debian-based os.
"
" Plugins are installed under "~/.vim/bundle" or "~\vimfiles\bundle". Pathogen
" makes it real easy and quick. Just clone the plugin repo and run ":Helptags"
" and it is done. Some plugins may require more steps.
"
" Some plugin-related variables need to be set before the plugin is loaded, so
" they better be placed earlier in this file.
"
" It is better to use one plugin for one functionality only, such as one for
" formatting and another for completion. It is easy to manage this way.
"
" Install "Pathogen" first. Bundles I use:
" --------------------------------------------
" ack          | faster searching      | ,a
" autoformat   | formatting tool       | <f3>
" coc.nvim     | conquer completion    |
" commentary   | comment stuff out     | ;c
" ctrl-p       | fuzzy file finder     | ,,
" emmet        | html,css abbrevs      | <c-e>
" fugitive     | git integration       |
" gitgutter    | git diff sign         |
" nerdtree     | tree file explorer    | <f2>
" polyglot     | syntax highlighting   |
" supertab     | insert completion     |
" tabular      | align things          | ;a
" --------------------------------------------
"
" Be sure to install "ack" before cloning. It has a dependency on "Perl". Better
" experienece with "ag" installed. "ack", "strawberryperl", "ag" can be easily
" installed via "choco".
"
" Both "ctrlp" and "ack" defaults to the directory of current file.
"
" Be sure to install "clang-format", "prettier" via "npm", install "autopep8",
" "pycodestyle" via "pip", install "html-tidy" via "choco" to make "autoformat"
" work normally. "clang-format" requires a ".clang-format" config file at root
" directory.
"
" Be sure to have "node" installed for using "coc.nvim". Install "coc-json",
" "coc-marketplace" with ":CocInstall". "coc-extensions" I use:
" --------------------------------------------
" coc-clangd                | .c,.cpp
" coc-css                   | .css,.scss
" coc-html                  | .html
" coc-html-css-support      |
" coc-json                  | .json,.jsonc
" coc-pyright               | .py
" coc-tsserver              | .js
" coc-vetur                 | .vue
" --------------------------------------------
"
" Install "clangd" for "coc-clangd" to work.
"
" Filetype-specific abbreviations are put separately in section "Abbreviations"
" instead of "FileType-specific Settings" cause it seems chunky if it was there.
"
" Huge thanks go to @stevelosh and his amazing "learnvimscriptthehardway" book
" for teaching me to customize this editor and enhance user experienece sooooo
" much. Best regards.

" }}}

" Variables ------------------------------------- {{{

" Define "g:os" using feature detection, thanks romainl.
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" Just in case it's not by default under home directory.
if has("win64") || has("win32") || has("win16")
    let $MYVIMRC = "$HOME/_vimrc"
else
    let $MYVIMRC = "$HOME/.vimrc"
endif

" Leader keys, my preferences.
let mapleader = ","
let maplocalleader = ";"

" This enables folding feature for markdown files if you are using the latest
" version of Vim, for some reason it is not documented, yet it is indeed
" a built-in feature.
let g:markdown_folding=1

" This defines pairs that need to be deleted with one key stroke, achieved with
" function BetterBS(). "#" is the cursor's position. Thanks Zorzi.
"
" Also pairs that need an indent after hitting return, achieved with function
" BetterCR().
let g:bs_couples = ['(#)', '[#]', '{#}', '<#>', '"#"', "'#'", '`#`', '*#*']
let g:cr_couples = ['>#<', '[#]', '{#}', '`#`']

" This defines a dictionary with commentstrings that should be used in embedded
" code according to the filetype, thanks suy.
let g:context_commentstrings = {
            \ 'html': {
            \     'javaScript': '//%s',
            \     'cssStyle': '/*%s*/',
            \ },
            \ 'vue': {
            \     'javaScript': '//%s',
            \     'cssStyle': '/*%s*/',
            \ },
            \}

" }}}

" Plugin-related Settings ----------------------- {{{

" Ack ---------------------- {{{

" Ack motions {{{

nnoremap <silent> <leader>A :set opfunc=<SID>AckMotion<cr>g@
xnoremap <silent> <leader>A :<c-u>call <SID>AckMotion(visualmode())<cr>

fu! s:AckMotion(type) abort
    let reg_save = @"

    if a:type ==# 'v'
        silent exe "norm! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
        silent exe "norm! `[v`]y"
    endif

    exe "norm! :Ack! --literal " . shellescape(@") . "\<cr>"

    let @" = reg_save
endfu

" }}}

" With a "bang", it will not jump to the first result automatically.
nnoremap <leader>a :Ack!<space>

" Use "ag" as searching tool, better install it first.
let g:ackprg='ag --smart-case --nogroup --nocolor --column'

" }}}

" Autoformat --------------- {{{

let g:formatdef_prettier='"prettier --stdin-filepath ".expand("%:p").(&textwidth ? " --print-width ".&textwidth : "")." --tab-width ".shiftwidth()." --single-quote"'

let g:formatters_c          = ['clangformat']
let g:formatters_cpp        = ['clangformat']
let g:formatters_python     = ['autopep8']
let g:formatters_html       = ['tidy_html']
let g:formatters_markdown   = ['prettier']
let g:formatters_javascript = ['prettier']
let g:formatters_css        = ['prettier']
let g:formatters_scss       = ['prettier']
let g:formatters_less       = ['prettier']
let g:formatters_json       = ['prettier']

noremap <F3> :Autoformat<cr>
inoremap <F3> <esc>:Autoformat<cr>

aug ft_jsonc
    au!
    au FileType jsonc noremap <buffer> <F3> :Autoformat json<cr>
    au FileType jsonc inoremap <buffer> <F3> <esc>:Autoformat json<cr>
aug end

aug ft_clangformat
    au!
    au BufNewFile,BufRead _clang-format,.clang-format setl ft=yaml
aug end

" }}}

" Coc.nvim ----------------- {{{

nmap <F4> <Plug>(coc-definition)
imap <F4> <esc><Plug>(coc-definition)

nnoremap <leader>cc :CocCommand<space>
nnoremap <leader>ci :CocInstall<space>

nnoremap <leader>cm :CocList marketplace<cr>

" }}}

" Commentary --------------- {{{

nmap ;c <Plug>CommentaryLine
xmap ;c <Plug>Commentary

" }}}

" Ctrl-P ------------------- {{{

nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>E :CtrlP ../

let g:ctrlp_map='<leader>,'
let g:ctrlp_cmd='CtrlP'

" Don't jump to it if already opened, open a new instance instead.
let g:ctrlp_switch_buffer=0

let g:ctrlp_match_window='bottom,order:ttb' . ',max:20'
let g:ctrlp_working_path_mode='ra'

" }}}

" Emmet -------------------- {{{

au FileType html,css,javascript,vue imap <buffer> <c-e> <c-y>,
au FileType html,css,javascript,vue imap <buffer> <c-s> <c-y>n

let g:user_emmet_mode='i'
let g:user_emmet_install_global=0

au FileType html,css,javascript,vue if exists(':EmmetInstall') | exe 'EmmetInstall' | endif

" }}}

" Fugitive ----------------- {{{

nnoremap <leader>G :Git<space>

nnoremap <leader>ga :Git add<space>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gd :Git diff<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gs :Git<cr>

nnoremap <leader>gci :Git commit<cr>
nnoremap <leader>gco :Git checkout<space>

" }}}

" NERDTree ----------------- {{{

nnoremap <F2> :NERDTreeToggle<cr>
inoremap <F2> <esc>:NERDTreeToggle<cr>

aug filetype_nerdtree
    au!
    au FileType nerdtree setl nolist
aug end

" }}}

" Polyglot ----------------- {{{

let g:polyglot_disabled=['autoindent']

" }}}

" Supertab ----------------- {{{

let g:SuperTabDefaultCompletionType='<c-n>'
let g:SuperTabLongestHighlight=1

" }}}

" Tabular ------------------ {{{

noremap ;a :Tabularize /=<cr>

" }}}

" }}}

filetype off
call pathogen#infect()
filetype plugin indent on
syntax on

runtime macros/matchit.vim
map <tab> %
silent! unmap [%
silent! unmap ]%

" Options --------------------------------------- {{{

" Backups ------------------ {{{

set backup                                     " enable backups
set noswapfile                                 " it's 2021, Vim.

if g:os == "Windows"
    set undodir  =~\vimfiles\tmp\undo\\        " undo files
    set backupdir=~\vimfiles\tmp\backup\\      " backups
    set directory=~\vimfiles\tmp\swap\\        " swap files
elseif g:os == "Linux"
    set undodir  =~/.vim/tmp/undo//            " undo files
    set backupdir=~/.vim/tmp/backup//          " backups
    set directory=~/.vim/tmp/swap//            " swap files
endif

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}

" Statusline --------------- {{{

set statusline=                                " Thanks Tassos!
set statusline+=\ %n\                          " buffer number
set statusline+=%{&ff}                         " file format
set statusline+=%y                             " file type
set statusline+=\ %<%F                         " full path
set statusline+=%1*%m%*\                       " modified flag
set statusline+=%2*%{FugitiveStatusline()}%*   " git branch
set statusline+=%=%5l                          " current line
set statusline+=/%L                            " total lines
set statusline+=%4v\                           " virtual column number
set statusline+=0x%04B\                        " character under cursor

hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
hi User2 term=inverse,bold cterm=inverse,bold ctermfg=blue

" }}}

" Wildmenu ----------------- {{{

set wildmenu
set wildmode=list:longest

set wildignore+=.git                           " version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
set wildignore+=*.obj,*.exe,*.dll              " compiled object files
set wildignore+=*.zip,*.rar,*.7z,*.tar.gz      " compressed files
set wildignore+=*.deb,*.rpm,*.pkg              " package files
set wildignore+=*.sw?                          " swap files
set wildignore+=*.DS_Store                     " mac bullshit

" }}}

set nocompatible
set encoding=utf-8
set modelines=0
set laststatus=2
set hidden
set nonumber
set norelativenumber
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set foldlevelstart=0
set wrap
set textwidth=80
set colorcolumn=+1
set list
set listchars=tab:▸\ ,trail:⌴
set complete=.,w,b,u,t
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmode
set showcmd
set showbreak=↪
set splitbelow
set splitright
set autoread
set autowrite
set formatoptions=qrn1j
set virtualedit+=block
set shortmess+=Ic
set visualbell t_vb=
set backspace=indent,eol,start
set scrolloff=3
set sidescroll=1
set sidescrolloff=10
set updatetime=100

" }}}

" Abbreviation ---------------------------------- {{{

" Filetype-specific -------- {{{

" C {{{

aug ft_c_abbrev
    au!
    au FileType c,cpp inorea <buffer> mm int main(int argc, char *argv[]) {<cr><cr><cr><cr>}<up><tab>return 0;<up><up><tab><c-r>=EatNextWhiteChar()<cr>
    au FileType c,cpp inorea <buffer> ii #include <%><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType c,cpp inorea <buffer> if if (%) {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType c,cpp inorea <buffer> fi for (int i = 0; i < %; ++i) {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType c,cpp inorea <buffer> fj for (int j = 0; j < %; ++j) {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType c,cpp inorea <buffer> ww while (%) {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType c,cpp inorea <buffer> fd /** Brief: %<cr><cr> Args: <cr><cr>Return: <cr><esc>a/<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
aug end

" }}}

" Javascript {{{

aug ft_javascript_abbrev
    au!
    au FileType javascript inorea <buffer> if if (%) {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType javascript inorea <buffer> fi for (let i = 0; i < %; ++i) {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType javascript inorea <buffer> fj for (let j = 0; j < %; ++j) {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType javascript inorea <buffer> ww while (%) {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType javascript inorea <buffer> fa function %() {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType javascript inorea <buffer> fb function(%) {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType javascript inorea <buffer> fc (%) => {<cr><cr>}<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType javascript inorea <buffer> fe forEach(function(%) {<cr><cr>});<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType javascript inorea <buffer> lg console.log(%);<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
aug end

" }}}

" Python {{{

aug ft_python_abbrev
    au!
    au FileType python inorea <buffer> mm def main():<cr>print("Hello World!")<cr><cr>if __name__ == "__main__":<c-d><cr>main()<up><up><up><esc>o<c-r>=EatNextWhiteChar()<cr>
    au FileType python inorea <buffer> ii import
    au FileType python inorea <buffer> if if % :<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType python inorea <buffer> fi for i in range(%):<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType python inorea <buffer> fj for j in range(%):<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType python inorea <buffer> ww while % :<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType python inorea <buffer> fu def %():<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
aug end

" }}}

" Vim {{{

aug ft_vim_abbrev
    au!
    au FileType vim inorea <buffer> if if %<cr><cr>endif<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType vim inorea <buffer> fi for i in %<cr><cr>endfor<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType vim inorea <buffer> fj for j in %<cr><cr>endfor<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType vim inorea <buffer> ww while %<cr><cr>endwhile<up><c-r>=repeat(' ', indent(line('.')-1)+&shiftwidth)<cr><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType vim inorea <buffer> aa aug %<cr>au!<cr><cr>aug end<c-d><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
    au FileType vim inorea <buffer> fu fu! %()<cr><cr>endfu<up><tab><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>
aug end

" }}}

" }}}

iab wmail nerdzzh@gmail.com
iab wname Will Chao

iab waht what
iab teh  the
iab tehn then

iab <expr> lhost 'http://127.0.0.1:'.EatNextWhiteChar()
iab <expr> dts strftime("%x %X %z")

" }}}

" Mappings -------------------------------------- {{{

" Normal mode -------------- {{{

" Window mappings {{{

" Move between windows.
nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>

" Maximize [h]eight/[w]idth of current window.
" Make [a]ll windows equal height and width.
nnoremap <leader>mh <c-w>_
nnoremap <leader>mw <c-w><bar>
nnoremap <leader>ma <c-w>=

" [r]otate all windows counterclockwise.
" E[x]change current window with its nearest.
nnoremap <leader>wr <c-w><c-r>
nnoremap <leader>wx <c-w><c-x>

" Move window to that direction.
nnoremap <leader>wh <c-w>H
nnoremap <leader>wj <c-w>J
nnoremap <leader>wk <c-w>K
nnoremap <leader>wl <c-w>L

" Move current window to a new [t]ab.
nnoremap <leader>wt <c-w>T

" Resize window's height.
nnoremap <leader>- :resize -10<cr>
nnoremap <leader>+ :resize +10<cr>

" Resize window's width.
nnoremap - :vertical resize -5<cr>
nnoremap + :vertical resize +5<cr>

" }}}

" Moving and jumping {{{

" Move to the beginning/end of line.
nnoremap H ^
nnoremap L $

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around.
nnoremap <c-o> <c-o>zz
nnoremap <c-n> <c-i>zz
nnoremap <c-]> <c-]>zz
nnoremap <c-\> <c-w>v<c-]>zz
nnoremap g; g;zz
nnoremap g, g,zz

" }}}

" Toggling {{{

" Space to toggle folds.
nnoremap <space> za

" [i]nvisible characters.
nnoremap <leader>i :set list!<cr>

" Line [n]umbers.
nnoremap <leader>n :set number!<cr>

" }}}

" Formatting {{{

" Easier linewise reselection of what you just pasted.
nnoremap <leader>V V`]

" Indent/dedent/autoindent what you just pasted.
nnoremap =- V`]=

" Reformat line. I never use l as a macro register anyway.
nnoremap ql gqq

" }}}

" Quick editing {{{

nnoremap <leader>wq :wq<cr>
nnoremap <leader>ww :w<cr>
nnoremap <leader>qq :q<cr>
nnoremap <leader>fq :q!<cr>

nnoremap <leader>ws :w<cr>:so %<cr>
nnoremap <leader>ss :so %<cr>

nnoremap <silent> <leader>sv :so $MYVIMRC<cr>:noh<cr>

nnoremap <leader>eb :vsp ~/.bashrc<cr>
nnoremap <leader>ec :vsp<cr>:CocConfig<cr>
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>ez :vsp ~/.zshrc<cr>

" }}}

" It's good practice to stop using arrow keys.
nnoremap <left>  <nop>
nnoremap <right> <nop>
nnoremap <up>    <nop>
nnoremap <down>  <nop>

" Buffer mappings
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bd :bp\|bd #<cr>
nnoremap <leader>bb :ls<cr>:buffer<space>

" Quickfix window
nnoremap <leader>qo :copen 18<cr>
nnoremap <leader>qn :cnext<cr>
nnoremap <leader>qp :cprevious<cr>

" Capitalize a word.
nnoremap <c-u> mzgUiw`z

" Enclose a word.
nnoremap <leader>" mzviw<esc>a"<esc>bi"<esc>`z
nnoremap <leader>' mzviw<esc>a'<esc>bi'<esc>`z
nnoremap <leader>( mzviw<esc>a)<esc>bi(<esc>`z
nnoremap <leader>` mzviw<esc>a`<esc>bi`<esc>`z
nnoremap <leader>[ mzviw<esc>a]<esc>bi[<esc>`z

" Show unsaved diff.
" nnoremap <leader>sd :w !diff -u % -<cr>
nnoremap <leader>sd :ShowDiff<cr>

" Select entire buffer.
nnoremap <leader>sa ggVG

" No search highlighting.
nnoremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

" Clean trailing whitespaces.
nnoremap <silent> <leader>W mz:let _s=@/<cr>:%s/\s\+$//e<cr>:noh<cr>:let @/=_s<cr>`z

" }}}

" Insert mode -------------- {{{

" Better keys {{{

" Delete a pair of brackets
inoremap <silent> <bs> <c-r>=<SID>BetterBS()<cr>

" Auto indent after pressing return
inoremap <silent> <cr> <c-r>=<SID>BetterCR()<cr>

" }}}

" Exit insert mode.
inoremap jk <esc>

" Pairing stuff up.
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Filename completion.
inoremap <c-f> <c-x><c-f>

" Move current line to the middle of the window.
inoremap <c-n> 1<esc>zza<bs>

" Paste from clipboard.
inoremap <c-p> <esc>"+pa

" Capitalize a word.
inoremap <c-u> <esc>mzgUiw`za

" }}}

" Visual mode -------------- {{{

" Selection {{{

" Enclosing a selection
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`>
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>`>
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>`>
vnoremap <leader>` <esc>`>a`<esc>`<i`<esc>`>
vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>`>

" Searching a selection
vnoremap // y/\m<c-r>=escape(@",'/\')<cr><cr>

" Formatting a selection
vnoremap Q gq

" }}}

" Clipboard manipulation.
vnoremap <leader>y "+y
vnoremap <leader>d "+d

" To the last non-blank character of the line.
vnoremap L g_

" Space to toggle folds.
vnoremap <space> za

" Deal with a delay when exiting visual mode.
vnoremap <esc> <c-c>

" }}}

" Command-line mode -------- {{{

" Pairing stuff up.
cnoremap " ""<left>
cnoremap ' ''<left>
cnoremap ( ()<left>
cnoremap [ []<left>
cnoremap { {}<left>

" }}}

" }}}

" Movements ------------------------------------- {{{

" Move to the beginning/end of line
onoremap H ^
onoremap L $

" Inside [p]arentheses
onoremap p i(

" Inside double [q]uotes
onoremap q i"

" Inside [s]ingle quotes
onoremap s i'

" Inside [b]ack quotes
onoremap b i`

" Inside cu[r]ly braces
onoremap r i{

" }}}

" FileType-specific Settings -------------------- {{{

" C ------------------------ {{{

aug ft_c
    au!
    au FileType c,cpp if exists('b:match_words') | let b:match_words.= ',\%(\<else\s\+\)\@<!' . '\<if\>:\<else\s\+if\>:\<else\>' . ',\<\(while\|for\)\>:\<continue\>:\<break\>' | else | let b:match_words= ',\%(\<else\s\+\)\@<!' . '\<if\>:\<else\s\+if\>:\<else\>' . ',\<\(while\|for\)\>:\<continue\>:\<break\>' | endif

    au FileType c,cpp setl softtabstop=4 shiftwidth=4
    au FileType c,cpp setl foldmethod=marker foldmarker={,}

    " Use ";h" to add file header.
    au FileType c,cpp nnoremap <buffer> <localleader>h ggO/** Author: Will Chao <nerdzzh@gmail.com><cr> Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: %<cr><esc>a/<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>

    " Use ";r" to run without args.
    au FileType c,cpp nnoremap <buffer> <localleader>r :call <SID>ClangRunCurrentFile()<cr>

    " Use ";s" to add semicolon to eol.
    au FileType c,cpp nnoremap <buffer> <localleader>s A;<esc>
aug end

" }}}

" CSS ---------------------- {{{

aug ft_css
    au!
    au FileType css setl softtabstop=2 shiftwidth=2
    au FileType css setl foldmethod=marker foldmarker={,}
    au FileType css setl formatoptions-=o

    " Use ";h" to add file header.
    au FileType css nnoremap <buffer> <localleader>h ggO/** Author: Will Chao <nerdzzh@gmail.com><cr> Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: %<cr><esc>a/<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>

    " Use ";s" to add semicolon to eol.
    au FileType css nnoremap <buffer> <localleader>s A;<esc>

    " Use ";f" to format properties.
    au FileType css nnoremap <buffer> <localleader>f :let _s=@"<CR>?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>:let @"=_s<CR>
aug end

" }}}

" HTML --------------------- {{{

aug ft_html
    au!
    au FileType html setl softtabstop=2 shiftwidth=2
    au FileType html setl formatoptions+=l
    au FileType html setl foldmethod=manual

    au FileType html inoremap <buffer> < <><left>

    " Use ";h" to add file header.
    au FileType html nnoremap <buffer> <localleader>h ggO<!--<cr><c-d>Author: Will Chao <nerdzzh@gmail.com><cr>Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: %<cr>--><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>

    " Use ";f" to fold current tag.
    au FileType html nnoremap <buffer> <localleader>f Vatzf

    " Use ";i" to indent current tag.
    au FileType html nnoremap <buffer> <localleader>i Vat=
aug end

" }}}

" Java --------------------- {{{

aug ft_java
    au!
    au FileType java if exists('b:match_words') | let b:match_words.= ',\%(\<else\s\+\)\@<!' . '\<if\>:\<else\s\+if\>:\<else\>' . ',\<\(while\|for\)\>:\<continue\>:\<break\>' | else | let b:match_words= ',\%(\<else\s\+\)\@<!' . '\<if\>:\<else\s\+if\>:\<else\>' . ',\<\(while\|for\)\>:\<continue\>:\<break\>' | endif

    au FileType java setl softtabstop=4 shiftwidth=4
    au FileType java setl foldmethod=marker foldmarker={,}

    " Use ";h" to add file header.
    au FileType java nnoremap <buffer> <localleader>h ggO/** Author: Will Chao <nerdzzh@gmail.com><cr> Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: %<cr><esc>a/<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>

    " Use ";r" to run without args.
    au FileType java nnoremap <buffer> <localleader>r :call <SID>JavaRunCurrentFile()<cr>

    " Use ";s" to add semicolon to eol.
    au FileType java nnoremap <buffer> <localleader>s A;<esc>
aug end

" }}}

" Javascript --------------- {{{

aug ft_javascript
    au!
    au FileType javascript if exists('b:match_words') | let b:match_words.= ',\%(\<else\s\+\)\@<!' . '\<if\>:\<else\s\+if\>:\<else\>' . ',\<\(while\|for\)\>:\<continue\>:\<break\>' | else | let b:match_words= ',\%(\<else\s\+\)\@<!' . '\<if\>:\<else\s\+if\>:\<else\>' . ',\<\(while\|for\)\>:\<continue\>:\<break\>' | endif

    au FileType javascript setl softtabstop=2 shiftwidth=2
    au FileType javascript setl foldmethod=marker foldmarker={,}
    au FileType javascript setl formatoptions-=o

    au FileType javascript inoremap <buffer> ` ``<left>

    " Use ";f" to add function description.
    au FileType javascript nnoremap <buffer> <localleader>f :call JSDocAdd()<cr>

    " Use ";h" to add file header.
    au FileType javascript nnoremap <buffer> <localleader>h ggO/** Author: Will Chao <nerdzzh@gmail.com><cr> Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: %<cr><esc>a/<esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>

    " Use ";r" to run without args.
    au FileType javascript nnoremap <buffer> <localleader>r :call <SID>JavascriptRunCurrentFile()<cr>

    " Use ";s" to add semicolon to eol.
    au FileType javascript nnoremap <buffer> <localleader>s A;<esc>
aug end

" }}}

" JSON --------------------- {{{

aug ft_json
    au!
    au FileType json syntax match Comment +\/\/.\+$+
aug end

" }}}

" Markdown ----------------- {{{

aug ft_markdown
    au!
    au FileType markdown setl softtabstop=2 shiftwidth=2
    au FileType markdown setl comments=b:*,b:-,b:+,n:>
    au FileType markdown setl formatoptions+=r
    au FileType markdown setl foldlevel=3

    au FileType markdown inorea <buffer> h1 #
    au FileType markdown inorea <buffer> h2 ##
    au FileType markdown inorea <buffer> h3 ###
    au FileType markdown inorea <buffer> h4 ####
    au FileType markdown inorea <buffer> h5 #####
    au FileType markdown inorea <buffer> h6 ######

    au FileType markdown inoremap <buffer> ' '
    au FileType markdown inoremap <buffer> ` ``<left>
    au FileType markdown inoremap <buffer> * **<left>

    " Use ";h" to add file header.
    au FileType markdown nnoremap <buffer> <localleader>h ggO<!--<cr><c-d>Author: Will Chao <nerdzzh@gmail.com><cr>Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: %<cr>--><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>

    " Use ";t" to generate toc.
    au FileType markdown nnoremap <buffer> <localleader>t :call <SID>MarkdownTocGenerate()<cr>

    " Use ";u" to update toc.
    au FileType markdown nnoremap <buffer> <localleader>u :call <SID>MarkdownTocUpdate()<cr>

    " Use ";j" to jump to anchor.
    au FileType markdown nnoremap <buffer> <localleader>j :call <SID>MarkdownJumpToAnchor()<cr>

    " Use "ih" and "ah" to move "inside" and "around" heading, thanks Steve.
    au FileType markdown onoremap <buffer> ih :<c-u>execute "norm! ?^#\\{1,6} \r:nohlsearch\rgn\elv$h"<cr>
    au FileType markdown onoremap <buffer> ah :<c-u>execute "norm! ?^#\\{1,6} \r:nohlsearch\rv$h"<cr>

    " Use ";b" to make bold, ";i" to make italic, ";d" to cross out.
    au FileType markdown nnoremap <buffer> <localleader>b mzviw<esc>a**<esc>hbi**<esc>`z
    au FileType markdown vnoremap <buffer> <localleader>b <esc>`>a**<esc>`<i**<esc>`>
    au FileType markdown nnoremap <buffer> <localleader>i mzviw<esc>a*<esc>bi*<esc>`z
    au FileType markdown vnoremap <buffer> <localleader>i <esc>`>a*<esc>`<i*<esc>`>
    au FileType markdown nnoremap <buffer> <localleader>d mzviw<esc>a~~<esc>hbi~~<esc>`z
    au FileType markdown vnoremap <buffer> <localleader>d <esc>`>a~~<esc>`<i~~<esc>`>

    " Fix markdown highlighting.
    au FileType markdown silent call <SID>FixMarkdownHl()

    " Auto-align bars when creating tables.
    au FileType markdown inoremap <buffer> <silent> <bar> <bar><esc>:call <SID>BarAutoAlign()<cr>a

    " Auto-update toc on save.
    au BufWritePre *.{md,markdown} call <SID>MarkdownTocUpdate()
aug end

" }}}

" Python ------------------- {{{

aug ft_python
    au!
    au FileType python if exists('b:match_words') | let b:match_words.= '\<if\>:\<elif\>:\<else\:\>' . ',\<\(while\|for\)\>:\<continue\>:\<break\>' | else | let b:match_words= '\<if\>:\<elif\>:\<else\:\>' . ',\<\(while\|for\)\>:\<continue\>:\<break\>' | endif

    au FileType python setl softtabstop=4 shiftwidth=4
    au FileType python setl foldmethod=indent foldnestmax=2 foldlevel=1

    " Use ";f" to add function description.
    au FileType python nnoremap <buffer> <localleader>f :let _s=@/<cr>?def<cr>:let @/=_s<cr>o"""%<cr><cr>Args:<cr><cr>Return:<c-d><cr><cr>"""<c-d><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>

    " Use ";h" to add file header.
    au FileType python nnoremap <buffer> <localleader>h ggO# Author: Will Chao <nerdzzh@gmail.com><cr>Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: <c-r>=EatNextWhiteChar()<cr>

    " Use ";r" to run without args.
    au FileType python nnoremap <buffer> <localleader>r :call <SID>PythonRunCurrentFile()<cr>
aug end

" }}}

" QuickFix ----------------- {{{

aug ft_quickfix
    au!
    au FileType qf setl colorcolumn=0 nolist nocursorline nowrap tw=0
aug end

" }}}

" Sh ----------------------- {{{

aug ft_sh
    au!

    au FileType sh,zsh setl softtabstop=2 shiftwidth=2
    au FileType sh,zsh setl foldmethod=marker foldmarker={{{,}}}
    au FileType sh,zsh setl formatoptions-=o

    " Use ";h" to add file header.
    au FileType sh,zsh nnoremap <buffer> <localleader>h ggO#!/usr/bin/env bash<cr># Author: Will Chao <nerdzzh@gmail.com><cr>Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: <c-r>=EatNextWhiteChar()<cr>
aug end

" }}}

" Vim ---------------------- {{{

aug ft_vim
    au!
    au FileType vim setl softtabstop=4 shiftwidth=4
    au FileType vim setl foldmethod=marker foldmarker={{{,}}}
    au FileType vim setl formatoptions-=o

    au FileType vim inoremap <buffer> < <><left>

    " Use ";f" to add function description.
    au FileType vim nnoremap <buffer> <localleader>f :let _s=@/<cr>?fu<cr>:let @/=_s<cr>O" Brief: %<cr><cr>Args: <cr><cr>Return: <esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>

    " Use ";h" to add file header.
    au FileType vim nnoremap <buffer> <localleader>h ggO" Author: Will Chao <nerdzzh@gmail.com><cr>Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: <c-r>=EatNextWhiteChar()<cr>
aug end

" }}}

" Vue ---------------------- {{{

aug ft_vue
    au!
    au FileType vue setl softtabstop=2 shiftwidth=2
    au FileType vue setl formatoptions+=l
    au FileType vue setl foldmethod=manual

    au FileType vue inoremap <buffer> ` ``<left>

    " Use ";f" to fold current tag.
    au FileType vue nnoremap <buffer> <localleader>f Vatzf

    " Use ";i" to indent current tag.
    au FileType vue nnoremap <buffer> <localleader>i Vat=

    " Use ";s" to add semicolon to eol.
    au FileType vue nnoremap <buffer> <localleader>s A;<esc>
aug end

" }}}

" XML ---------------------- {{{

aug ft_xml
    au!
    au FileType xml setl softtabstop=2 shiftwidth=2
    au FileType xml setl formatoptions+=l
    au FileType xml setl foldmethod=manual

    au FileType xml inoremap <buffer> < <><left>

    " Use ";h" to add file header.
    au FileType xml nnoremap <buffer> <localleader>h ggO<!--<cr><c-d>Author: Will Chao <nerdzzh@gmail.com><cr>Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: %<cr>--><esc>:let _s=@/<cr>?%<cr>:let @/=_s<cr>:noh<cr>a<bs><c-r>=EatNextWhiteChar()<cr>

    " Use ";f" to fold current tag.
    au FileType xml nnoremap <buffer> <localleader>f Vatzf

    " Use ";i" to indent current tag.
    au FileType xml nnoremap <buffer> <localleader>i Vat=
aug end

" }}}

" YAML --------------------- {{{

aug ft_yaml
    au!
    au FileType yaml setl softtabstop=2 shiftwidth=2
    au FileType yaml setl foldmethod=indent foldnestmax=2
    au FileType yaml setl formatoptions-=o

    " Use ";h" to add file header.
    au FileType yaml nnoremap <buffer> <localleader>h ggO# Author: Will Chao <nerdzzh@gmail.com><cr>Filename: <c-r>=expand("%:p:t")<cr><cr>Last Change: <c-r>=strftime("%x %X %z")<cr><cr>Brief: <c-r>=EatNextWhiteChar()<cr>
aug end

" }}}

" }}}

" Functionality --------------------------------- {{{

" Better keys -------------- {{{

" Brief: Delete a pair of brackets with one key stroke.
"
" Return:
"   1. "\<BS>" in most cases.
"   2. Pairs of "\<BS>\<DEL>" between "()[]{}<>".
" Note:
"   1. This approach only works when "backspace" option has "start".
"   2. "#" indicates the cursor position.
fu! s:BetterBS() "{{{
    for l:couple in g:bs_couples
        if !(l:couple =~ '#')
            continue
        endif

        let l:regex = substitute(escape(l:couple, '/\^$*.[~'), '#', '\\%#', '')

        if search(l:regex, 'n')
            let l:out = repeat("\<BS>", len(matchstr(l:couple, '^.\{-}\ze#')))
            let l:out .= repeat("\<DEL>", len(matchstr(l:couple, '#\zs.\{-}$')))

            return l:out
        endif
    endfor

    return "\<BS>"
endfu "}}}

" Brief: Auto indent after pressing return between tags.
"
" Return:
"   1. "\<CR>" in most cases.
"   2. "\<CR>\<CR>\<UP>" and multiple "\<TAB>"s between tags.
fu! s:BetterCR() "{{{
    for l:couple in g:cr_couples
        if !(l:couple =~ '#')
            continue
        endif

        let l:regex = substitute(escape(l:couple, '/\^$*.[~'), '#', '\\%#', '')

        if search(l:regex, 'n')
            " "autoindent" option does not remember indent of a blank line , so
            " we have to repeat the indent of current line and +1.
            let l:out = "\<CR>\<CR>\<UP>"
            let l:out .= repeat(' ', indent('.') + &shiftwidth)

            return l:out
        endif
    endfor

    return "\<CR>"
endfu "}}}

" }}}

" Run files ---------------- {{{

" Brief: Quit if current window is the last one.
fu! s:MyLastWindow() "{{{
    if &ft=='jsresult' || &ft=='pythonresult' || &ft=='clangresult' || &ft=='javaresult'
        if winnr('$') == 1
            quit
        endif
    endif
endfu "}}}

aug last_window
    au!
    au BufEnter * call <SID>MyLastWindow()
aug end

" Brief: Show the result of "node file.js" in a split window.
fu! s:JavascriptRunCurrentFile() "{{{
    let l:js_command = "node "

    " Get the result of running.
    let l:result = system(l:js_command . bufname("%"))

    " Create a new split, or switch to it if it exists.
    if bufwinnr("__JS_Result__") == -1
        vsp __JS_Result__
    else
        exe bufwinnr("__JS_Result__") . "wincmd w"
    endif

    " Clear the buffer, and set buffer type.
    norm! ggdG
    setl ft=jsresult
    setl bt=nofile

    " Show the result.
    call append(0, split(l:result, '\m\n'))

    " Switch back to the original window.
    exe bufwinnr("#") . "wincmd w"
endfu "}}}

" Brief: Show the result of "python file.py" in a split window.
fu! s:PythonRunCurrentFile() "{{{
    let l:python_command = "python "

    " Get the result of running.
    let l:result = system(l:python_command . bufname("%"))

    " Create a new split, or switch to it if it exists.
    if bufwinnr("__Python_Result__") == -1
        vsp __Python_Result__
    else
        exe bufwinnr("__Python_Result__") . "wincmd w"
    endif

    " Clear the buffer, and set buffer type.
    norm! ggdG
    setl ft=pythonresult
    setl bt=nofile

    " Show the result.
    call append(0, split(l:result, '\m\n'))

    " Switch back to the original window.
    exe bufwinnr("#") . "wincmd w"
endfu "}}}

" Brief: Show the result of "cl file.c/cpp" in a split window.
fu! s:ClangRunCurrentFile() "{{{
    let l:clang_command = "cl "

    " Compiling...
    let l:compile_msg = system(l:clang_command . bufname("%"))

    " Grab error message if any.
    let l:error = []
    for l:msg in split(l:compile_msg, '\n')
        if l:msg =~ 'error'
            call add(l:error, l:msg)
        endif
    endfor

    " If any errors, display the error, otherwise the result.
    if len(l:error) != 0
        let l:result = l:error
    else
        " Get file name for concatenating.
        let l:fname = substitute(bufname("%"), '\.\(c\|cpp\)$', '', '')

        " Get the result of running.
        let l:result = split(system('.\' . l:fname . '.exe'), '\n')

        " Clean obsolete files generated during compiling.
        call delete(l:fname . '.obj') | call delete(l:fname . '.exe')
    endif

    " Create a new split, or switch to it if it exists.
    if bufwinnr("__Clang_Result__") == -1
        vsp __Clang_Result__
    else
        exe bufwinnr("__Clang_Result__") . "wincmd w"
    endif

    " Clear the buffer, and set buffer type.
    norm! ggdG
    setl ft=clangresult
    setl bt=nofile

    " Show the result.
    call append(0, l:result)

    " Switch back to the original window.
    exe bufwinnr("#") . "wincmd w"
endfu "}}}

" Brief: Show the result of "java file.java" in a split window.
fu! s:JavaRunCurrentFile() "{{{
    let l:java_compile_command = "javac "
    let l:java_run_command = "java "

    let l:fname = substitute(bufname('%'), '\.java$', '', '')

    " Compiling...
    call system(l:java_compile_command . bufname('%'))

    " Cleaning...
    call delete(l:fname . 'class')

    " Running...
    let l:result = system(l:java_run_command . l:fname)

    " Appeding...
    if bufwinnr('__Java_Result__') == -1
        vsp __Java_Result__
    else
        exe bufwinnr('__Java_Result__') . 'wincmd w'
    endif
    norm! ggdG
    setl ft=javaresult
    setl bt=nofile
    call append(0, l:result)
    exe bufwinnr('#') . 'wincmd w'
endfu "}}}

" }}}

" Utils -------------------- {{{

" Brief: Eat next white character when typing abbreviation.
fu! EatNextWhiteChar() "{{{
    let c = nr2char(getchar(0))
    return c =~# '\s' ? '' : c
endfu "}}}

" }}}

" Markdown Toc "{{{

" Brief: Generate table of contents if does't exist.
fu! s:MarkdownTocGenerate() "{{{
    let l:winview = winsaveview()
    keepjumps norm! gg0

    if search('<!-- TOC START -->', 'Wc') != 0
        call winrestview(l:winview)
        return
    endif

    let l:headingLineRegex = '\m^#\{1,6}'

    let l:headingLines  = []
    let l:headingLevels = []
    let l:headingNames  = []
    let l:headingLinks  = []

    while search(l:headingLineRegex, 'W') != 0
        if getline('.') =~? 'table.*of.*contents'
            continue
        else
            call add(l:headingLines, getline('.'))
        endif
    endwhile

    for l:headingLine in l:headingLines
        call add(l:headingLevels, match(l:headingLine, '[^#]'))
    endfor

    for l:headingLine in l:headingLines
        let l:headingName = substitute(l:headingLine, '^#\+\s\+', '', '')
        let l:headingName = substitute(l:headingName, '\s\+#\+$', '', '')
        let l:headingName = substitute(l:headingName, '\[\([^\[\]]*\)\]([^()]*)', '\1', 'g')
        let l:headingName = substitute(l:headingName, '\[\([^\[\]]*\)\]\[[^\[\]]*\]', '\1', 'g')

        call add(l:headingNames, l:headingName)
        call add(l:headingLevels, match(l:headingLine, '[^#]'))
    endfor

    for l:headingName in l:headingNames
        let l:headingLink = tr(l:headingName, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')
        let l:headingLink = substitute(l:headingLink, "\\%#=0[^[:alnum:]\u00C0-\u00FF\u0400-\u04ff\u4e00-\u9fbf\u3040-\u309F\u30A0-\u30FF\uAC00-\uD7AF _-]", "", "g")
        let l:headingLink = substitute(l:headingLink, ' ', '-', 'g')

        call add(l:headingLinks, l:headingLink)
    endfor

    call winrestview(l:winview)

    if len(l:headingLevels) == 0
        return
    endif

    silent put ='<!-- TOC START -->'
    silent put =''
    silent put =repeat('#', min(l:headingLevels)).' '.'Table of contents'
    silent put =''

    let i = 0
    for l:headingLine in l:headingLines
        let l:heading = ''
        let l:heading .= repeat(' ', (l:headingLevels[i] - min(l:headingLevels)) * &shiftwidth)
        let l:heading .= '- '
        let l:heading .= '[' . l:headingNames[i] . ']'
        let l:heading .= '(#' . l:headingLinks[i] . ')'

        silent put =l:heading
        let i += 1
    endfor

    silent put =''
    silent put ='<!-- TOC END -->'
endfu "}}}

" Brief: Update existing table of contents if exists.
fu! s:MarkdownTocUpdate() "{{{
    let l:winview = winsaveview()
    keepjumps norm! gg0

    if search('<!-- TOC START -->', 'Wc') != 0
        let l:beginLineNum = line('.')
        if search('<!-- TOC END -->', 'W') != 0
            let l:endLineNum = line('.')
            silent exe l:beginLineNum . ',' . l:endLineNum . 'delete_'

            call cursor(l:beginLineNum -1, 1)
            call <SID>MarkdownTocGenerate()
        endif
    endif

    call winrestview(l:winview)
endfu "}}}

" Brief: Jump to anchor in table of content.
fu! s:MarkdownJumpToAnchor() "{{{
    let saveReg = @"
    norm! ^f#vi(y
    let l:anchorName = substitute(@", '^#', '', '')
    let @" = saveReg

    let l:winview = winsaveview()
    keepjumps norm! gg0

    let l:headingLineRegex = '\m^#\{1,6}'

    let l:headingLines  = []
    let l:headingNames  = []
    let l:headingLinks  = []

    let l:headingLineNum = []

    while search(l:headingLineRegex, 'W') != 0
        call add(l:headingLines, getline('.'))
        call add(l:headingLineNum, line('.'))
    endwhile

    for l:headingLine in l:headingLines
        let l:headingName = substitute(l:headingLine, '^#\+\s\+', '', '')
        let l:headingName = substitute(l:headingName, '\s\+#\+$', '', '')
        let l:headingName = substitute(l:headingName, '\[\([^\[\]]*\)\]([^()]*)', '\1', 'g')
        let l:headingName = substitute(l:headingName, '\[\([^\[\]]*\)\]\[[^\[\]]*\]', '\1', 'g')

        call add(l:headingNames, l:headingName)
    endfor

    for l:headingName in l:headingNames
        let l:headingLink = tr(l:headingName, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')
        let l:headingLink = substitute(l:headingLink, "\\%#=0[^[:alnum:]\u00C0-\u00FF\u0400-\u04ff\u4e00-\u9fbf\u3040-\u309F\u30A0-\u30FF\uAC00-\uD7AF _-]", "", "g")
        let l:headingLink = substitute(l:headingLink, ' ', '-', 'g')

        call add(l:headingLinks, l:headingLink)
    endfor

    let i = 0
    for l:headingLink in l:headingLinks
        if l:headingLink ==# l:anchorName
            call cursor(l:headingLineNum[i], 1)
            norm! zzzv
            return
        endif
        let i += 1
    endfor

    call winrestview(l:winview)
endfu "}}}

" }}}

" Diff --------------------- {{{

" Brief: Show unsaved changes in a split with highlight.
fu! s:DiffUnsavedChanges() "{{{
    let l:diff_cmd  = 'diff -u'

    let l:file_name = expand('%')
    let l:temp_name = tempname()

    exe 'silent w!' . l:temp_name
    let diff = system(l:diff_cmd.' '.shellescape(l:file_name).' '.l:temp_name)
    call delete(l:temp_name)

    if bufwinnr('__My_Diff__') == -1
        sp __My_Diff__
    else
        exe bufwinnr('__My_Diff__') . 'wincmd w'
    endif
    norm! ggdG
    setl ft=mydiff
    setl bt=nofile

    call append(0, split(diff, '\n'))

    hi myDiffBefore ctermfg=red
    hi myDiffAfter  ctermfg=green

    syn match myDiffBefore "^-.*$"
    syn match myDiffAfter  "^+.*$"
endfu "}}}

" Brief: Turn on highlight in diff window.
fu! s:DiffHighlight() "{{{
    if &ft=='mydiff'
        hi myDiffBefore ctermfg=red
        hi myDiffAfter  ctermfg=green
    else
        hi clear myDiffBefore
        hi clear myDiffAfter
    endif
endfu "}}}

command! -nargs=0 ShowDiff :silent! call <SID>DiffUnsavedChanges()<cr>

aug mydiff
    au!
    au BufEnter * call <SID>DiffHighlight()
aug end

" }}}

" Context Commentstring ---- {{{

aug context_cs
    au!
    au FileType html,vue call <SID>ContextCommentstringEnable()
aug end

fu! s:ContextCommentstringEnable() "{{{
    aug context_cs_enable
        au! CursorMoved <buffer>

        if !empty(&filetype)&&has_key(g:context_commentstrings, &filetype)
            let b:original_commentstring=&commentstring
            au CursorMoved <buffer> call <SID>ContextCommentstringUpdate()
        endif
    aug end
endfu "}}}

fu! s:ContextCommentstringUpdate() "{{{
    let stack=synstack(line('.'), col('.'))
    if !empty(stack)
        for name in map(stack, 'synIDattr(v:val, "name")')
            if has_key(g:context_commentstrings[&filetype], name)
                let &commentstring=g:context_commentstrings[&filetype][name]
                return
            endif
        endfor
    endif
    let &commentstring=b:original_commentstring
endfu "}}}

" }}}

" Brief: Fix markdown highlighting on **.
fu! s:FixMarkdownHl() "{{{
    " From $VIMRUNTIME/syntax/markdown.vim.
    let s:concealends = ''
    if has('conceal') && get(g:, 'markdown_syntax_conceal', 1) == 1
        let s:concealends = ' concealends'
    endif

    " From commit [e875717] by @Tim Pope, changed from "\\*" to "\\\*".
    exe 'syn region markdownItalic matchgroup=markdownItalicDelimiter start="\S\@<=\*\|\*\S\@=" end="\S\@<=\*\|\*\S\@=" skip="\\\*" contains=markdownLineStart,@Spell' . s:concealends
    exe 'syn region markdownBold matchgroup=markdownBoldDelimiter start="\S\@<=\*\*\|\*\*\S\@=" end="\S\@<=\*\*\|\*\*\S\@=" skip="\\\*" contains=markdownLineStart,markdownItalic,@Spell' . s:concealends
    exe 'syn region markdownBoldItalic matchgroup=markdownBoldItalicDelimiter start="\S\@<=\*\*\*\|\*\*\*\S\@=" end="\S\@<=\*\*\*\|\*\*\*\S\@=" skip="\\\*" contains=markdownLineStart,@Spell' . s:concealends

    " From $VIMRUNTIME/syntax/markdown.vim.
    hi def link markdownItalic                htmlItalic
    hi def link markdownItalicDelimiter       markdownItalic
    hi def link markdownBold                  htmlBold
    hi def link markdownBoldDelimiter         markdownBold
    hi def link markdownBoldItalic            htmlBoldItalic
    hi def link markdownBoldItalicDelimiter   markdownBoldItalic
endfu "}}}

" Brief: Auto-align bars when creating tables in markdown. Thanks tpope.
fu! s:BarAutoAlign() "{{{
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfu "}}}

" Brief: If modified, update any "Last Change" occurrences in first 20 lines.
fu! UpdateTimestamps() "{{{
    if &modified
        " Save cursor position.
        let save_cursor = getpos(".")

        " Substitution applies to the first 20 lines.
        let line_range  = min([20, line("$")])

        " "keepjumps" excludes timestamp position from jump list.
        keepjumps exe '1,' . line_range . 's@^\(.\{,10}Last Change: \).*@\1' . strftime("%x %X %z") . '@e'

        " Remove timestamp search pattern from search history.
        call histdel("search", -1)

        " Restore last search pattern.
        let @/ = histget("search", -1)

        " Restore cursor position.
        call setpos(".", save_cursor)
    endif
endfu "}}}

" Brief: Generate JSDoc-like function description. Thanks Joe.
fu! JSDocAdd() "{{{
    let l:pat1 = 'function \([a-zA-Z]*\)\s*(\s*\(.*\)\s*).*'
    let l:pat2 = '\S*\s*\([a-zA-Z]*\)\s*[:=]\s*function\s*(\s*\(.*\)\s*).*'
    let l:pat3 = '\S*\s*\([a-zA-Z]*\)\s*[:=]\s*(\s*\(.*\)\s*)\s*=>.*'

    let l:line = getline('.')
    let l:indent = indent('.')
    let l:space = repeat(" ", l:indent)

    let l:flag = 1
    if l:line =~ l:pat1
        let l:regex = l:pat1
    elseif l:line =~ l:pat2
        let l:regex = l:pat2
    elseif l:line =~ l:pat3
        let l:regex = l:pat3
    else
        let l:flag = 0
    endif

    if l:flag
        let l:lines = []
        let l:desc = input('Description: ')
        let l:funcName = substitute(l:line, l:regex, '\1', "g")
        call add(l:lines, l:space. '/**')
        call add(l:lines, l:space . ' * ' . l:funcName .'() ' . l:desc)
        let l:arg = substitute(l:line, l:regex, '\2', "g")
        let l:args = split(l:arg, '\s*,\s*')
        call add(l:lines, l:space . ' *')
        for l:arg in l:args
            call add(l:lines, l:space . ' * @param {...} ' . l:arg . " -")
        endfor
        call add(l:lines, l:space . ' *')
        call add(l:lines, l:space . ' * @return {...}')
        call add(l:lines, l:space . ' */')
        call append(line('.')-1, l:lines)
    endif
endfu "}}}

" }}}

" Commands -------------------------------------- {{{

" Timestamps --------------- {{{

aug timestamp
    au!
    au BufWritePre * call UpdateTimestamps()
aug end

" }}}

" Cursorline --------------- {{{

aug cline
    au!

    " Only show cursorline in current window and in normal mode.
    " au WinLeave,InsertEnter * set nocursorline
    " au WinEnter,InsertLeave * set cursorline
aug end

" }}}

" Trailing whitespace ------ {{{

aug trailing
    au!

    " Only shown when not in insert mode so I don't go insane.
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
aug end

" }}}

" Line return -------------- {{{

aug line_return
    au!

    " Make sure Vim returns to the same line when you reopen a file.
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     exe 'norm! g`"zvzz' |
        \ endif
aug end

" }}}

" }}}
