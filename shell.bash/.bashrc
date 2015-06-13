#
# ~/.bashrc
#
# /etc/profile -> /etc/profile.d/* -> starting of (~/.bash_profile & ~/.bashrc) -> startx -> rest of (~/.bash_profile & ~/.bashrc)
# startx -> ~/.xinitrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ $debug_bash == "true" ]]; then
    echo "*** /home/sbhal/.bashrc ***"
fi

set -o vi

alias vi='vim'
alias g='gvim'
alias brc='vim /home/sbhal/.bashrc'
#alias startx='startx &> '/home/sbhal/.Xoutput''
#start emacs maximized
alias emacs='emacs -mm'
alias ee='echo $?'
alias ctagsc='ctags --languages=C -R .'
alias ctagscpp='ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extra=+q --language-force=c++ .'
alias gitsanity='~/droid/scripts/git'
alias foldersize='du -sch .[!.]* * |sort -h'

alias email='echo "" | mail -s "Server: $(hostname -s) $(date) Job Finished. Enjoy!" sbhal@qti.qualcomm.com'

# locale-gen
export LANG=en_US.UTF-8

## Modified commands ## {{{
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 3'
alias dmesg='dmesg -HL'
# }}}

## New commands ## {{{
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep'         # requires an argument
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias pgg='ps -Af | grep'           # requires an argument
# }}}

# Privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudoedit'
    alias root='sudo -s'
    #    alias reboot='sudo systemctl reboot'
    alias update='sudo pacman -Su'
    alias netctl='sudo netctl'
fi

## ls ## {{{
alias ls='ls -hF --color=auto'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
# }}}

#cd () {
#    if builtin cd ${1:+"$@"} && [ -r ./startIT.sh ]; then
#        . ./startIT.sh
#    fi
#}


## Safety features ## {{{
alias cp='cp -i'
alias mv='mv -i'
#alias rm='rm -I'                    # 'rm -i' prompts for every file
# safer alternative w/ timeout, not stored in history
#alias rm=' timeout 3 rm -Iv --one-file-system'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias cls=' echo -ne "\033c"'       # clear screen for real (it does not work in Terminology)
# }}}

## Make Bash error tolerant ## {{{
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias cd..='cd ..'
# }}}

export HISTCONTROL=ignoredups:erasedups        # no duplicate entries
export HISTSIZE=100000                         # big big history
export HISTFILESIZE=100000                     # big big history
shopt -s histappend                            # append to history, don't overwrite it
export PROMPT_COMMAND="history -a; history -n" # updates history file to sync b/w terminal


# Compile and execute a C source on the fly
csource() {
    if [ -z "$1" ]; then
        echo "Missing operand";
        return 1;
    fi
    local OUTPUT_PATH=$(echo "$1" | sed -e "s/^.*\/\|^/\/tmp\//" | sed -e "s/\.c$//");
    gcc "$1" -o "$OUTPUT_PATH" && "$OUTPUT_PATH";
    rm "$OUTPUT_PATH";
    return 0;
}

# cd and ls in one
cl() {
    dir=$1
    if [[ -z "$dir" ]]; then
        dir=$HOME
    fi
    if [[ -d "$dir" ]]; then
        cd "$dir"
        ls
    else
        echo "bash: cl: '$dir': Directory not found"
    fi
}

note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch $HOME/.notes
    fi

    if [[ $# -eq 0 ]]; then
        # no arguments, print file
        cat $HOME/.notes
    elif [[ "$1" == "-c" ]]; then
        # clear file
        echo "" > $HOME/.notes
    else
        # add all arguments to file
        echo "$@" >> $HOME/.notes
    fi
}

todo() {
    if [[ ! -f $HOME/.todo ]]; then
        touch $HOME/.todo
    fi

    if [[ $# -eq 0 ]]; then
        cat $HOME/.todo
    elif [[ "$1" == "-l" ]]; then
        cat -n $HOME/.todo
    elif [[ "$1" == "-c" ]]; then
        echo "" > $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        cat -n $HOME/.todo
        echo -ne "----------------------------\nType a number to remove: "
        read NUMBER
        sed -ie ${NUMBER}d $HOME/.todo
    else
        echo "$@" >> $HOME/.todo
    fi
}

calc() {
    echo "scale=3;$@" | bc -l
}


# bash-completion package for tab completion with inputrc configs

#trap for non zero returns
#EC() { echo -e '\e[1;33m'code $?'\e[m\n'; }
#trap EC ERR

#history bound with arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


#emacs no window
#alias emacscmd='emacs -nw'


export EDITOR=vim

scope() {

    read OPT;
    # -t 1 attributeacan be sued to specify timeout value

    if [[ -z $OPT ]] 
    then
        if [[ -f "cscope.out" ]]
        then
            export EDITOR=vim
            export VIMSRC=$(pwd)
            cscope -d
            return 0
        else 
            return 1
        fi
    fi


    echo '1. Build and Export to pwd'
    echo '2. export VIMSRC kk35'
    echo '3. export VIMSRC master'


    read OPT;
    if [[ $OPT = "1" ]] 
    then
        CWD=$(pwd)
        cscope -bqkR
        export VIMSRC=$CWD

    elif [[ $OPT = "2" ]] 
    then
        export VIMSRC=/local/mnt/workspace/sbhal/kk35
    elif [[ $OPT = "3" ]] 
    then
        export VIMSRC=/local/mnt/workspace/sbhal/master
    elif [[ $OPT = "22" ]] 
    then
        export VIMSRC=/local/mnt/workspace/sbhal/kk35/vendor/qcom/opensource/wlan/prima
    elif [[ $OPT = "2" ]] 
    then
        export VIMSRC=/local/mnt/workspace/sbhal/kk35
    else
        return 0
    fi
}

mytmux() {

    SESSIONNAME="bhal"
    tmux has-session -t $SESSIONNAME &> /dev/null

    if [ $? != 0 ] 
    then
        tmux new-session -s $SESSIONNAME -n main -d
        #        tmux send-keys -t $SESSIONNAME "~/bin/script" C-m 
    fi

    tmux attach -t $SESSIONNAME
}

alias ttop='cd $TTOP';
wservice () {
    DIRECTORY="/hardware/qcom/wlan/wcnss-service/"
    if [ -d "$ANDROID_BUILD_TOP$DIRECTORY" ]; then
        cd "$ANDROID_BUILD_TOP$DIRECTORY"
        return 0
    fi
}
wplatform () {
    DIRECTORY="/kernel/drivers/net/wireless/wcnss/"
    if [ -d "$ANDROID_BUILD_TOP$DIRECTORY" ]; then
        cd "$ANDROID_BUILD_TOP$DIRECTORY"
        return 0
    fi
}
cplatform () {
    DIRECTORY="/kernel/drivers/net/wireless/cnss/"
    if [ -d "$ANDROID_BUILD_TOP$DIRECTORY" ]; then
        cd "$ANDROID_BUILD_TOP$DIRECTORY"
        return 0
    fi
}
dtsi () {
    DIRECTORY="/kernel/arch/arm/boot/dts/qcom"
    if [ -d "$ANDROID_BUILD_TOP$DIRECTORY" ]; then
        cd "$ANDROID_BUILD_TOP$DIRECTORY"
        return 0
    fi
}
prima_ver () {
    vim CORE/MAC/inc/qwlan_version.h;
}
prima_gpl () {
    vim CORE/HDD/src/wlan_hdd_main.c
}
prima() {
    DIRECTORY="/vendor/qcom/opensource/wlan/prima/"
    if [ -d "$ANDROID_BUILD_TOP$DIRECTORY" ]; then
        cd "$ANDROID_BUILD_TOP$DIRECTORY"
        return 0
    fi
}
primap() {
    DIRECTORY="/vendor/qcom/proprietary/wlan-noship/prima/"
    if [ -d "$ANDROID_BUILD_TOP$DIRECTORY" ]; then
        cd "$ANDROID_BUILD_TOP$DIRECTORY"
        return 0
    fi
    cd "$ANDROID_BUILD_TOP"vendor/qcom-proprietary/wlan/prima/""
}
out() {
    if [ -d "$ANDROID_PRODUCT_OUT" ]; then
        cd "$ANDROID_PRODUCT_OUT"
        return 0
    fi
}
src() {
    export TTOP=$(pwd)
    . build/envsetup.sh
    . startIT
}
gtags_env_update() {
    export GTAGSROOT=$(pwd)
    gtags
    source ~/.bashrc
}
cpstartit() {
    cp ~/droid/scripts/startIT .
    vim startIT
}
alias cindex_reset='cindex -reset && cindex -list'
cindex_au() {
    croot &&
    cindex -reset  &&
    cindex ./vendor/qcom/proprietary/wlan-noship/prima
    cindex ./kernel/drivers/net/wireless/wcnss
    cindex ./vendor/qcom/proprietary/wlan/utils/ptt
    cindex ./kernel/include/linux/wcnss_wlan.h
    cindex -list
}


function color_my_prompt {
local __cur_location="\$(if [[ \$? == 0 ]]; then echo \[$(tput setaf 2)\]\"\W\"; else echo \[$(tput smul)\]\[$(tput setaf 1)\]\"\W\"; fi)"
local __git_branch_color="\[\033[31m\]"
#local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
local __prompt_tail="\[\033[35m\]$"
local __last_color="\[\033[00m\]"
export PS1="$__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
#color_my_prompt
source ~/git-completion.bash
#source ~/droid/scripts/ps3.sh
export PATH="/usr2/sbhal/droid/bin:$PATH"
# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt

#  export ANDROID_NDK=/local/mnt/workspace/sbhal/android/android-ndk-r9d
#  export ANDROID_SDK=/local/mnt/workspace/sbhal/android/android-sdk-linux/tools
#  export SYSROOT=$ANDROID_NDK/platforms/android-18/arch-arm

export ws=/local/mnt/workspace/sbhal
export patch=/local/mnt/workspace/sbhal/dump/patch

#eval $(dircolors -b ~/.dir_colors)
export PATH="/usr2/sbhal/.linuxbrew/bin:$PATH"
export MANPATH="/usr2/sbhal/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/usr2/sbhal/.linuxbrew/share/info:$INFOPATH"

