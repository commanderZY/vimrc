## vim折腾小结
___

## 版本说明

| 版本   | 作者   | 日期       | 备注   |
| ---- | ---- | -------- | ---- |
| 0.1  | ZY   | 2019.3.4 | 初稿   |
| 0.2  | ZY   | 2019.3.11| 添加neocomplete安装及配置；修改部分笔误 |

## 目录

[TOC]

## 一、初衷
折腾了一圈，从vim到VS到Qt Creator到SourceInsight到Eclipse，最终可以说还是各有所长吧，在开发一些运行在Linux设备上的使用c/c++开发的模块时使用vim加上cmake这种畅快和专注感还是让人无法自拔，所以我又折腾了一番vim。

这里的内容包括了之前关于vim的整理的相关博客的一部分内容，这里将其整合，后续更新将基于此。

## 二、效果展示

折腾后在Xshell5上连接服务器使用效果如下：

![image](096C6B2014DC4C8B8685BC82FCB07E99)

## 三、安装vim

参考：
https://www.linuxidc.com/Linux/2017-09/147108.htm

本次安装基于Ubuntu16.04 64位，支持Python3。

### 1、安装vim依赖

无论你是源码安装还是sudo apt-get安装，建议安装以下依赖：
```shell
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev liblua5.1 lua5.1-dev libperl-dev git
```
### 2、安装vim

#### 1）源码安装

源码安装建议卸载已有版本：
```shell
//查询已有版本
dpkg -l | grep vim
//卸载已有版本
sudo apt-get remove vim-common vim-tiny
```

源码安装方式，建议从Git下载，之后根据依赖安装：
```shell
git clone https://github.com/vim/vim.git
```
之后根据你需要的Python配置进行安装：
```shell
//支持Python3

./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
--enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.5/config \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr

//如果想让vim8支持python2，执行下面的操作：

./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
```
之后编译安装即可：
```shell
make VIMRUNTIMEDIR=/usr/share/vim/vim80

sudo make install
```

查看结果：
```shell
vim --version
```

查看python3支持：
```shell
打开vim，在命令模式下，即输入：
:echo has('python3')
```
结果为1则支持Python3，否则不支持，Python及其它模块同理。

#### 2）apt-get安装

在Ubuntu上可以使用如下命令安装：

```shell
sudo apt-get update
sudo apt-get install vim
```

## 四、配置vim

对于Git，这里我不想多说了，这个基本上是现在程序的标配只一了,至少需要了解基本的使用，Ubuntu下简单安装方法：
```shell
sudo apt-get update
sudo apt-get install git
```

### 1、首先我们需要一个插件管理的插件

目前基本上都是使用vundle了，我目前也从pathogen改为使用vundle了。

https://github.com/VundleVim/Vundle.vim

#### 1）vundle安装

如果没有.vim和bundle目录则创建，之后：

```shell
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

如上vundle就安装好了。

#### 2）vundle简单配置

如果~目录下没有.vimrc文件则创建，之后打开.virmc进行vundle配置：

vim ~/.vimrc

```vim
"========================================================================================
" vundle插件管理工具设置
"========================================================================================
" vundle插件路径
set rtp+=~/.vim/bundle/Vundle.vim
" 在这里面输入安装的插件
call vundle#begin()
" Vundle 本身就是一个插件
Plugin 'gmarik/Vundle.vim'
"状态栏美化插件
zy@chuangmi:~$ head .vimrc -n 30
"========================================================================================
" vundle插件管理工具设置
"========================================================================================
" vundle插件路径
set rtp+=~/.vim/bundle/Vundle.vim
" 在这里面输入安装的插件
call vundle#begin()
" Vundle 本身就是一个插件
Plugin 'gmarik/Vundle.vim'
"状态栏美化插件
Plugin 'Lokaltog/vim-powerline'
"tagbar
Plugin 'majutsushi/tagbar'
"NERDTree
Plugin 'scrooloose/nerdtree'
"Markdown相关插件
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"注释插件
Plugin 'scrooloose/nerdcommenter'
"快速输入结对符
Plugin 'jiangmiao/auto-pairs'
"所有插件都应该在这一行之前
"自动补全插件
Bundle 'ervandew/supertab'
call vundle#end()
```

在call vundle#begin()和call vundle#end()之间利用Bundle、Plugin等方法将需要的插件加入进去，之后打开vim，输入PluginInstall（记得活用tab键）：
```shell
:PluginInstall
```
那么vundle就会根据你输入的地址去GitHub上找插件进行安装下载，安装完成后会显示Done：

![image](1455015FBD2F46ADB36CAD5FC9706C5D)

其实vundle远不止这点作用，更多的用法你可以去GitHub上看，这里就不多说了。

#### 3）利用vundle卸载插件

只需要在.vimrc中先删除对应的插件Plugin xxx，然后打开vim，输入PluginClean即可自动删除对应的插件。

#### 4）利用vundle更新插件

只需要打开vim，然后输入PluginUpdate即可。

### 2、vim快捷键定义

vim快捷键定义基本上是通过vim的<Leader>来实现的，默认为“\”，这个你可以根据你自己的喜好来定义，比如我这里使用的是“；”。

这里简单展示一些我常用的快捷键设置：
```vim
"========================================================================================
"个人常用快捷键
"========================================================================================
" 定义快捷键的前缀，即<Leader>
let mapleader=";"
" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
"定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
"定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
"跳转至右方的窗口
nnoremap <Leader>l <C-W>l
"跳转至方的窗口
nnoremap <Leader>h <C-W>h
"跳转至上方的子窗口
nnoremap <Leader>k <C-W>k
"跳转至下方的子窗口
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
```

### 3、界面美化

vim默认不是很好看，而且黑色的看的时间长了眼睛也不舒服，我们将其美化一下。

#### 1）主体风格

主体风格需要在bundle目录下创建一个colors目录，然后将主体相关的插件的.vim放到该目录下，常见的主体风格有：素雅 solarized、多彩 molokai、复古 phd等，这些你可以自动搜索。

我这里介绍一个可以定制主体风格的网址:http://bytefluent.com/vivify/

![image](42ABA0A798B74239982F444E95E36E0A)

你可以自己通过设置RGB等定制你喜欢的风格，调整完后点那个下载按钮就会下载到一个.vim文件，然后将这个.vim复制到我前面说的colors文件夹下，然后在.vimrc中进行配置：

```vim
"1、主题风格                                                                                                                                                        
syntax enable
set background=dark
colorscheme corporation_modified
```

上面的corporation_modified就是我下载的.vim的名字，这里名字似乎不能改，下载的是什么名字就是什么。

我这里根据护眼色的RGB和色号（R:199 G:237 B:204 #:C7EDCC ）调整了一下，然后又将亮度稍微调低了一些，调整后如下：

![image](6314EFAB80D1472B972B68F22D73B2FC)

#### 2）营造专注气氛

如下是我的一些设置，这个主要是用在Windows下：
```vim
"2、营造专注气氛
"?禁止光标闪烁
set gcr=a:block-blinkon0
"?禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
"?禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T
```

#### 3）添加辅助信息

```vim
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
```

#### 4）其它美化

比如美化下状态栏，显示电脑电量等，自己定制。这里推荐一个美化状态栏的插件：
vim-powerline，安装就通过在vundle中增加Plugin 'Lokaltog/vim-powerline'的方式安装即可。

https://github.com/Lokaltog/vim-powerline

### 4、代码分析

#### 1）语法高亮

就和notepad++等编辑器一样，支持将不同的代码根据其规则高亮：
```vim
"1、语法高亮
" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on
```

#### 2）代码缩进

```vim
"2、代码缩进
"自适应不同语言的智能缩进
filetype indent on
"将制表符扩展为空格
set expandtab
"设置编辑时制表符占用空格数
set tabstop=4
"设置格式化时制表符占用空格数
set shiftwidth=4
"让vim把连续数量的空格视为一个制表符
set softtabstop=4
```
然后介绍一个插件，可视化的将相同缩进的代码关联起来(我使用体验一般，但是可以一试)：
Indent Guides（https://github.com/nathanaelkane/vim-indent-guides）

vundle的安装方法，加入：
Plugin 'nathanaelkane/vim-indent-guides'

然后配置如下：
```vim
"随vim自启动
let g:indent_guides_enable_on_vim_startup=1
"从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
"色块宽度
let g:indent_guides_guide_size=1
"快捷键i开/关缩进可视化
nmap <silent> <Leader>i <Plug>IndentGuidesToggle
```

这个是GitHub上的介绍图：

![image](71C64FA1A1294EE0A29F96A29D7DCDD1)

#### 3）代码折叠

vim自身支持多种折叠：手动建立折叠（manual）、基于缩进进行折叠（indent）、基于语法进行折叠（syntax）、未更改文本构成折叠（diff）等等，其中，indent、syntax比较适合编程，按需选用。增加如下配置信息：

```vim
"3、代码折叠
"基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
"启动vim时关闭折叠代码
set nofoldenable
```

操作：za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠。

#### 4）接口和实现快速切换

假如在接口文件中，vim自动帮我找到对应的实现文件，当键入快捷键，可以在当前窗口中打开对应实现文件，也可以在当前窗口中分裂一个子窗口显示对应实现文件。

a.vim（https://github.com/vim-scripts/a.vim）来了。

增加：Plugin 'vim-scripts/a.vim'进行安装。

安装后增加配置信息：

```vim
"4、接口与实现快速切换
" *.cpp和*.h间切换
nmap <Leader>ch :A<CR>
"子窗口中显示*.cpp或*.h
nmap <Leader>sch :AS<CR>
```

这样，键入;ch就能在实现文件和接口文件间切换，键入;sch子窗口中将显示实现文件/接口文件。

a.vim实现原理很简单，基于文件名进行关联，比如，a.vim能识别my_class.h与my_class.cpp，而无法识别my_class.h与your_class.cpp。所以，你在命名文件时得注意下。

#### 5）显示类、结构体、函数、变量等的标签

先安装ctags：

```shell
sudo apt-get install ctags
```

我这里使用tagbar插件进行这些信息的处理，https://github.com/majutsushi/tagbar

安装方法：Plugin 'majutsushi/tagbar'

之后配置：

```vim
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
```

github给出的效果图：

![image](70E52752BD154214B20CE7E30B073A04)

#### 6）工程文件树浏览

目前基本上都是使用NERDTree：https://github.com/scrooloose/nerdtree

安装方法：Plugin 'scrooloose/nerdtree'

之后配置如下：

```vim
"6、使用NERDTree插件查看工程文件
map <F7> :NERDTreeToggle<CR>
"设置NERDTree子窗口宽度
let NERDTreeWinSize=32
"设置NERDTree子窗口位置
let NERDTreeWinPos="right"
"显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
"删除文件时自动删除文件对应buffer
let NERDTreeAutoDeleteBuffer=1
```

以下是官方给出的效果图：

![image](3A2BCA3A854E451EB830960BFEE60404)

### 5、代码开发

#### 1）快速开关注释

NERD Commenter（https://github.com/scrooloose/nerdcommenter）

NERD Commenter根据编辑文档的扩展名自适应采用何种注释风格，如，文档名x.cpp则采用//注释风格，而x.c则是//注释风格；另外，如果选中的代码并非整行，那么该插件将用//只注释选中部分。

安装方法：Plugin 'scrooloose/nerdcommenter'

常用操作：（注释时先按数字确认从现在的位置注释到哪个位置，然后按分号，最后按快捷键，例如：19；cc就是从当前位置注释19行，取消注释同理。）

cc，注释当前选中文本，如果选中的是整行则在每行首添加//，如果选中一行的部分内容则在选中部分前后添加分别/、/；

cu，取消选中文本块的注释。

#### 2）模板补全

这里使用插件：UltiSnips（https://github.com/SirVer/ultisnips ）

在进行模板补全时，你是先键入模板名（如，if），接着键入补全快捷键（默认），然后UltiSnips根据你键入的模板名在代码模板文件中搜索匹配的“模板名-模板”，找到对应模板后，将模板在光标当前位置展开。

默认情况下，UltiSnips模板补全快捷键是tab，与后面介绍的supertab快捷键有冲突，所有须在.vimrc中重新设定。

此外，这里的UltiSnips只是一个引擎，还需要下载代码片段的插件：Plugin 'honza/vim-snippets'，所以需要安装这两个：

Plugin 'SirVer/ultisnips'

Plugin 'honza/vim-snippets'

之后修改配置：
```vim
"1、模板补全插件设置
"跳出模板结果
let g:UltiSnipsExpandTrigger="<leader><tab>"
"调到下一触发点
let g:UltiSnipsJumpForwardTrigger="<c-b>"
"调到上一个触发点
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
```

以下是官网给的效果：

https://camo.githubusercontent.com/296aecf30e1607233814196db6bd3f5f47e70c73/68747470733a2f2f7261772e6769746875622e636f6d2f5369725665722f756c7469736e6970732f6d61737465722f646f632f64656d6f2e676966

#### 3）快速输入结对符

使用插件auto-pairs(https://github.com/jiangmiao/auto-pairs)

安装方法：Plugin 'jiangmiao/auto-pairs'

#### 4）智能补全

目前用的多的是YouComplete和neocomplete，目前我先使用的是supertab结合neocomplete。

supertab：https://github.com/ervandew/supertab

安装方法：Plugin 'ervandew/supertab'

neocomplete：https://github.com/Shougo/neocomplete.vim

安装方法：Plugin 'Shougo/neocomplete'

配置如下：
```vim
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
```

#### 5）静态代码查错

目前我使用： https://github.com/vim-syntastic/syntastic.git

安装方法：Plugin 'vim-syntastic/syntastic'

### 6、未完待续。。。

vim配置文件上传至GitHub，将同步更新：

https://github.com/yaoyecaizi/vimrc.git

欢迎浏览我的小站：xiaoyaoyou.xyz
