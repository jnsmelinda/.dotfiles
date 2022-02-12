unsetopt PROMPT_SP
PS1=''

COMMON_FG_1='blue'
COMMON_FG_2='white'
COMMON_BG='light-black'

export ALIEN_KEEP_PROMPT=1
export ALIEN_PROMPT_SYM='❯'
export ALIEN_USE_NERD_FONT=1
export ALIEN_SECTIONS_LEFT_SEP_SYM=' '
export ALIEN_SECTIONS_RIGHT_SEP_SYM=' '
export ALIEN_SECTION_TIME_FORMAT='%H:%M:%S'
export ALIEN_THEME='soft'
# export ALIEN_VERSIONS_PROMPT='JAVA_S'

export ALIEN_PROMPT_FG=$COMMON_FG_1
export ALIEN_SECTION_EXIT_FG=$COMMON_BG
export ALIEN_SECTION_EXIT_BG=$COMMON_FG_1
export ALIEN_SECTION_EXIT_BG_ERROR='red'
export ALIEN_SECTION_TIME_FG=$COMMON_FG_2
export ALIEN_SECTION_TIME_BG=$COMMON_BG
export ALIEN_SECTION_BATTERY_FG=$COMMON_FG_1
export ALIEN_SECTION_BATTERY_BG=$COMMON_BG
export ALIEN_SECTION_USER_FG=$COMMON_FG_1
export ALIEN_SECTION_USER_BG=$COMMON_BG
export ALIEN_SECTION_PATH_FG=$COMMON_FG_1
export ALIEN_SECTION_PATH_BG=$COMMON_BG
export ALIEN_SECTION_VCS_BRANCH_FG=$COMMON_FG_2
export ALIEN_SECTION_VCS_BRANCH_BG=$COMMON_BG
export ALIEN_SECTION_VCS_STATUS_FG=$COMMON_FG_2
export ALIEN_SECTION_VCS_STATUS_BG=$COMMON_BG
export ALIEN_SECTION_VCS_DIRTY_FG=$COMMON_FG_2
export ALIEN_SECTION_VCS_DIRTY_BG=$COMMON_BG
export ALIEN_SECTION_SSH_FG=$COMMON_FG_2
export ALIEN_SECTION_VENV_FG=$COMMON_FG_2
export ALIEN_GIT_TRACKED_COLOR='green'
export ALIEN_GIT_UN_TRACKED_COLOR='red'
export ALIEN_JAVA_COLOR=$COMMON_FG_1
export ALIEN_NODE_COLOR=$COMMON_FG_1
export ALIEN_SECTION_VERSION_BG=$COMMON_BG

alien_prompt_section_java_version() {
    JAVA_HOME=$(asdf where java)
    eval $(cat $JAVA_HOME/release | grep JAVA_VERSION=)

    __section=(
        content "\ue256 $JAVA_VERSION"
        foreground "$COMMON_FG_1"
        separator 1
    )
}

alien_prompt_section_node_version() {
    NODE_VERSION="$(node --version)"

    __section=(
        content "\ue718 ${NODE_VERSION:1}"
        foreground "$COMMON_FG_1"
        separator 1
    )
}

alien_prompt_section_error_sensitive_prompt() {
    __section=(
        content " ${ALIEN_PROMPT_SYM} "
        foreground "%(?.$ALIEN_SECTION_EXIT_BG.$ALIEN_SECTION_EXIT_BG_ERROR)"
    )
}

alien_prompt_section_time-current() {
    __section=(
        content "H: $(date +'%I:%M%p')"
        foreground 'grey'
        separator 1
    )
}

alien_prompt_section_time-et() {
    __section=(
        content "ET: $(TZ=America/New_York date +'%I:%M%p')"
        foreground 'grey'
        separator 1
    )
}

export ALIEN_SECTIONS_RIGHT=(
    time-current
    time-et
    vcs_branch:async
    vcs_status:async
    vcs_dirty:async
    java_version:async
    node_version:async
)

export ALIEN_SECTIONS_LEFT=(
    # exit
    # battery
    # user
    path:async
    newline
    # ssh
    # venv
    # prompt
    error_sensitive_prompt
)

zinit ice wait lucid atload'precmd'; zinit light eendroroy/alien
