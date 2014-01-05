#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'



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
alias ping='ping -c 5'
alias dmesg='dmesg -HL'
# }}}

## New commands ## {{{
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep'         # requires an argument
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias pgg='ps -Af | grep'           # requires an argument
alias ..='cd ..'
# }}}

# Privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudoedit'
    alias root='sudo -s'
    alias reboot='sudo systemctl reboot'
    alias poweroff='sudo systemctl poweroff'
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
# }}}

## Safety features ## {{{
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
# safer alternative w/ timeout, not stored in history
alias rm=' timeout 3 rm -Iv --one-file-system'
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

## Pacman aliases ## {{{
#if necessary, replace 'pacman' with your favorite AUR helper and adapt the commands accordingly
alias pac="sudo /usr/bin/pacman -S"		# default action	- install one or more packages
alias pacu="/usr/bin/pacman -Syu"		# '[u]pdate'		- upgrade all packages to their newest version
alias pacr="sudo /usr/bin/pacman -Rns"		# '[r]emove'		- uninstall one or more packages
alias pacs="/usr/bin/pacman -Ss"		# '[s]earch'		- search for a package using one or more keywords
alias paci="/usr/bin/pacman -Si"		# '[i]nfo'		- show information about a package
alias paclo="/usr/bin/pacman -Qdt"		# '[l]ist [o]rphans'	- list all packages which are orphaned
alias pacc="sudo /usr/bin/pacman -Scc"		# '[c]lean cache'	- delete all not currently installed package files
alias paclf="/usr/bin/pacman -Ql"		# '[l]ist [f]iles'	- list all files installed by a given package
alias pacexpl="/usr/bin/pacman -D --asexp"	# 'mark as [expl]icit'	- mark one or more packages as explicitly installed 
alias pacimpl="/usr/bin/pacman -D --asdep"	# 'mark as [impl]icit'	- mark one or more packages as non explicitly installed

# '[r]emove [o]rphans' - recursively remove ALL orphaned packages
alias pacro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rns \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"
# }}}



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

extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                   c='bsdtar xvf';;
            *.7z)  c='7z x';;
            *.Z)   c='uncompress';;
            *.bz2) c='bunzip2';;
            *.exe) c='cabextract';;
            *.gz)  c='gunzip';;
            *.rar) c='unrar x';;
            *.xz)  c='unxz';;
            *.zip) c='unzip';;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac

        command $c "$i"
        e=$?
    done

    return $e
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

#PS1='[\u@\h \W]\$ '  # To leave the default one
#PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\] '

#return value visualisation
PS1="\[\033[01;37m\]\$? \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\];)\"; else echo \"\[\033[01;31m\];(\"; fi) $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\h'; fi)\[\033[01;34m\] \W \$\[\033[00m\] "
#mine v simple with last dir only 
#PS1="\h[\W]$ "

# bash-completion package for tab completion with inputrc configs

#trap for non zero returns
#EC() { echo -e '\e[1;33m'code $?'\e[m\n'; }
#trap EC ERR

#history bound with arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

#Switching off backlight
alias backlightoff='sleep 1 && xset dpms force off'

#Changing brightness of backlight
backlightChange(){
	echo $1 | sudo tee -a /sys/class/backlight/acpi_video0/brightness
}

#mount PenD
mountusb(){
	sudo mount /dev/$1 /run/media/usbdrive/
}

#unmount PenD
umountusb(){
	sudo umount /run/media/usbdrive
}

#emacs no window
alias emacscmd='emacs -nw'

#sorting pacman mirrors using reflector
alias mirrorlistUpdate='sudo reflector --verbose -l 50 -p http --sort rate --save /etc/pacman.d/mirrorlist'

#screenshot using graphicsMagic
alias screenshotComplete='gm import -winow root -quality 100 screenshot.jpg && feh screenshot.jpg'
alias screenshotSelective='gm import root screenshot.jpg && feh screenshot.jpg'

#dropbox 
dropbox_remove_cache='rm -r ~/Dropbox/.dropbox.cache/*'
