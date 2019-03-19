"========================================================================================
"一、vundle插件管理工具设置
"========================================================================================
" vundle插件路径
set rtp+=~/.vim/bundle/Vundle.vim
" 在这里面输入安装的插件
call vundle#begin()
" Vundle 本身就是一个插件
Plugin 'gmarik/Vundle.vim'
"状态栏美化插件
Plugin 'Lokaltog/vim-powerline'
"缩进代码可视化
Plugin 'nathanaelkane/vim-indent-guides'
"接口与实现快速跳转
Plugin 'vim-scripts/a.vim'
"tagbar
Plugin 'majutsushi/tagbar'
"NERDTree
Plugin 'scrooloose/nerdtree'
"注释插件
Plugin 'scrooloose/nerdcommenter'
"模板补全引擎
Plugin 'SirVer/ultisnips'
"模板补全代码片段
Plugin 'honza/vim-snippets'
"Markdown相关插件
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"快速输入结对符
Plugin 'jiangmiao/auto-pairs'
"自动补全插件
Plugin 'Shougo/neocomplete'
Bundle 'ervandew/supertab'
"所有插件都应该在这一行之前
call vundle#end()

"========================================================================================
"二、个人常用快捷键
"========================================================================================
" 定义快捷键的前缀，即<Leader>
let mapleader=";"
" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 跳转至右方的窗口
nnoremap <Leader>l <C-W>l
" 跳转至方的窗口
nnoremap <Leader>h <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>k <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>j <C-W>j
" 搜索时大小写不敏感
set ignorecase
" 开启实时搜索功能
set incsearch
" 关闭兼容模式
set nocompatible
"解决删除空格不起作用
set backspace=indent,eol,start
" vim 自身命令行模式智能补全
set wildmenu

"========================================================================================
"三、界面美化
"========================================================================================
"1、主题风格
syntax enable
set background=dark
colorscheme corporation_modified

"2、营造专注气氛
" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

"3、添加辅助信息
" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch

"4、其它美化

"========================================================================================
"四、代码分析
"========================================================================================
"1、语法高亮
" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

"2、代码缩进
" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim把连续数量的空格视为一个制表符
set softtabstop=4
"代码缩进可视化插件Indent-guides设置
" 随 vim自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i开/关缩进可视化
nmap <silent> <Leader>i <Plug>IndentGuidesToggle

"3、代码折叠
" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim时关闭折叠代码
set nofoldenable

"4、接口与实现快速切换
" *.cpp和*.h间切换
nmap <Leader>ch :A<CR>
"子窗口中显示*.cpp或*.h
nmap <Leader>sch :AS<CR>

"5、显示类、结构体、函数、变量等的标签
"设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_ctags_bin = '/usr/bin/ctags'
"设置tagbar的窗口宽度  
let g:tagbar_width=30  
"设置tagbar的窗口显示的位置,为左边  
let g:tagbar_left=1
"打开文件自动 打开tagbar  
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()  
"映射tagbar的快捷键  
map <F8> :TagbarToggle<CR>

"6、使用 NERDTree插件查看工程文件
map <F7> :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

"========================================================================================
"五、代码开发
"========================================================================================
"2、模板补全插件设置
"跳出模板结果
let g:UltiSnipsExpandTrigger="<leader><tab>"
"调到下一触发点
let g:UltiSnipsJumpForwardTrigger="<c-b>"
"调到上一个触发点
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"4、智能补全
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

"========================================================================================
"其它杂项
"========================================================================================
"解决复制黏贴乱码
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>
