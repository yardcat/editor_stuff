# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
#DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias lg='function grep_wrap(){ if [ -n "$1" ]; then grep "$1" * -nsr"$2"; fi; unset -f grep_wrap;};grep_wrap'
alias g="select_path"
alias p='python -ic "import sys;import os;"'
alias cman='cppman'
alias gs='git status'

function create_sc() {
  echo "" > cscope.files
  for i in android_webview media components cc content net  ui  base  gpu third_party/blink;
  do
    find "$i" -name "*.h" |grep -v "test" >> cscope.files
    find "$i" -name "*.cc" |grep -v "test" >> cscope.files
    find "$i" -name "*.cpp" |grep -v "test" >> cscope.files
    find "$i" -name "*.java" |grep -v "test" >> cscope.files
  done
  cscope -Rbqk
}

function add_sc() {
  find "$1" -name "*.h" |grep -v "test" >> cscope.files
  find "$1" -name "*.cc" |grep -v "test" >> cscope.files
  find "$1" -name "*.cpp" |grep -v "test" >> cscope.files
  find "$1" -name "*.java" |grep -v "test" >> cscope.files
  cscope -Rbqk
}

function create_fzf() {
  echo "" > cscope.files
  for i in android_webview media components cc content net  ui  base  gpu third_party/blink third_party/skia;
  do
    find "$i" -name "*.h" -o -name "*.java" -o -name "*.mojom" -o -name "*.gni" |grep -v "test" >> fzf.cache
  done
}

function add_fzf() {
  find "$1" -name "*.h" -o -name "*.java" -o -name "*.mojom" -o -name "*.gni" |grep -v "test" >> fzf.cache
}

#fast directory access
function select_path() {
  if [ -z "$1" ];then
    cd $prefix
  fi
  if [ $? -ne 0 ];then
    cd $ly_src
  fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
