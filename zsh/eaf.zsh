export EDITOR='code --wait'
export EDITOR_NOWAIT='code'
export BAT_STYLE='full'
export BAT_PAGER='less -rRXF'
export GPG_TTY=$(tty)
export FZF_CTRL_T_OPTS="--bind='enter:execute(code {})+abort' --preview 'bat --color \"always\" {}'"
export COPYFILE_DISABLE=1 # so that tar works properly on mac

export PATH="$PATH:/usr/local/sbin"
export MANPATH="/usr/local/man:$MANPATH"

alias dotfiles="$EDITOR_NOWAIT $HOME/.dotfiles"
alias la='ls -alh --git'
alias ls='exa'
alias cat='bat'
alias wttr="curl 'https://wttr.in/Bellevue?m'"
alias wttr+="curl 'https://v2.wttr.in/Bellevue?m'"
alias moon="curl 'https://wttr.in/Moon'"

alias docker-stop-all='docker stop $(docker ps -q)'
alias docker-rm-all='docker rm $(docker ps -aq)'
alias docker-rmi-all='docker rmi -f $(docker images -aq)'
alias docker-destroy-all='docker-stop-all && docker-rm-all && docker-rmi-all'

function killpidof() {
    if [ $# -eq 1 ]; then
        sudo kill `pidof $1`
    else
        echo "Usage: $0 <commandName>"
    fi
}

function cmdof() {
    if [ $# -eq 1 ]; then
        ps ax | grep $1
    else
        echo "Usage: $0 <commandName>"
    fi
}

function wholistens() {
    sudo lsof -PiTCP -sTCP:LISTEN
}

function colors() {
    for i in {0..255} ; do
        printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
        if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
            printf "\n";
        fi
    done
}

function me() {
    curl -s cli.fyi/me
}

function myip() {
    echo "local: $(mylocalip)"
    echo "public: $(mypublicip)"
}

function mylocalip() {
    ipconfig getifaddr en1 || ipconfig getifaddr en0
}

function mypublicip() {
    curl -s 'https://ifconfig.io'
}

function clipboard-fix() {
    echo 'restarting clipboard services...'
    killall pbs
    killall pboard
    launchctl start com.apple.pboard
    launchctl start com.apple.pbs
    killall Finder
    echo 'please restart your apps'
}

function dns-flush() {
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
}

function update() {
    echo 'zsh upgrade...'
    omz update
    zinit self-update
    zinit update --all

    echo 'brew update, upgrade, cleanup...'
    brew update
    brew upgrade
    brew upgrade --cask
    brew cleanup

    echo 'tldr update...'
    tldr --update

    echo 'asdf plugin-update...'
    asdf plugin-update --all

    echo 'npm update...'
    npm update npm -g && npm update -g

    echo 'softwareupdate update...'
    softwareupdate -i -a
}

function install-completions() {
    # first create completion file, e.g.: kind completion zsh > /usr/local/share/zsh/site-functions/_kind
    autoload -U compinit && compinit
}