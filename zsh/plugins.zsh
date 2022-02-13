export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH # homebrew completion hack

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-bin-gem-node
### End of Zinit's installer chunk

zinit wait lucid light-mode for \
    atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
        zdharma-continuum/fast-syntax-highlighting \
        OMZP::colored-man-pages \
    blockf zsh-users/zsh-completions \
    atload'!_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
    svn pick'completion.zsh' multisrc'git.zsh history.zsh' OMZ::lib

zinit wait lucid light-mode for \
    djui/alias-tips \
    Tarrasch/zsh-bd \
    rupa/z

export ASDF_GROOVY_DISABLE_JAVA_HOME_EXPORT=true
zinit wait lucid light-mode for \
    pick'asdf.sh' '/opt/homebrew/opt/asdf/libexec' \
    pick'set-java-home.zsh' "$HOME/.asdf/plugins/java"

zinit wait svn lucid light-mode for \
    OMZP::gradle \
    OMZP::mvn \
    blockf OMZP::docker-compose

zinit wait lucid light-mode for \
    pick'.fzf.zsh' %HOME

zinit lucid light-mode for \
    svn OMZ::plugins/git \
    pick'eaf.zsh' %HOME/.dotfiles/zsh

source $HOME/.dotfiles/zsh/async-prompt.zsh
