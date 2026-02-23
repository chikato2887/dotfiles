export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
alias "vim"="nvim"
alias "ll"="ls -la"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

### WORDCHARS (vim風のword単位移動にするため記号を除外)
WORDCHARS=''

### Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

### fzf (Ctrl+R: 履歴, Ctrl+T: ファイル, Ctrl+G: ディレクトリ移動)
export FZF_DEFAULT_OPTS="--bind 'ctrl-j:down,ctrl-k:up'"
# zsh-vi-mode がキーバインドを上書きするので、初期化後に fzf を読み込む
function zvm_after_init() {
  source <(fzf --zsh)
  bindkey '^G' fzf-cd-widget

  # Vim風移動キーバインド (vicmd = ノーマルモード)
  bindkey -M vicmd 'H' vi-backward-blank-word
  bindkey -M vicmd 'L' vi-forward-blank-word
  bindkey -M vicmd '^H' vi-backward-word
  bindkey -M vicmd '^L' vi-forward-word
}

### PATH
export PATH="$HOME/.local/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
