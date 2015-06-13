
function get_git_branch() {
# On branches, this will return the branch name
# On non-branches, (no branch)
ref="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
if [[ "$ref" != "" ]]; then
    echo "$ref"
else
    echo "(no branch)"
fi
}

is_branch1_behind_branch2 () {
    # $ git log origin/master..master -1
    # commit 4a633f715caf26f6e9495198f89bba20f3402a32
    # Author: Todd Wolfson <todd@twolfson.com>
    # Date:   Sun Jul 7 22:12:17 2013 -0700
    #
    #     Unsynced commit

    # Find the first log (if any) that is in branch1 but not branch2
    first_log="$(git log $1..$2 -1 2> /dev/null)"

    # Exit with 0 if there is a first log i.e success, 1 if there is not
    [[ -n "$first_log" ]]
}

branch_exists () {
    # List remote branches           | # Find our branch and exit with 0 or 1 if found/not found
    git branch --remote 2> /dev/null | grep --quiet "$1"
}

parse_git_ahead () {
    # Grab the local and remote branch
    branch="$(get_git_branch)"
    #remote_branch="origin/$branch"
    remote_branch="sync"

    # $ git log origin/master..master
    # commit 4a633f715caf26f6e9495198f89bba20f3402a32
    # Author: Todd Wolfson <todd@twolfson.com>
    # Date:   Sun Jul 7 22:12:17 2013 -0700
    #
    #     Unsynced commit

    # If the remote branch is behind the local branch
    # or it has not been merged into origin (remote branch doesn't exist)
    first_log="$(git log $remote_branch..$branch -1 2> /dev/null)"

    # Exit with 0 if there is a first log i.e success, 1 if there is not
    if [[ -n "$first_log" ]]; then
        echo "1"
    fi
}

parse_git_behind () {
    # Grab the branch
    branch="$(get_git_branch)"
    #remote_branch="origin/$branch"
    remote_branch="sync"

    # $ git log master..origin/master
    # commit 4a633f715caf26f6e9495198f89bba20f3402a32
    # Author: Todd Wolfson <todd@twolfson.com>
    # Date:   Sun Jul 7 22:12:17 2013 -0700
    #
    #     Unsynced commit

    first_log="$(git log $branch..$remote_branch -1 2> /dev/null)"

    # Exit with 0 if there is a first log i.e success, 1 if there is not
    if [[ -n "$first_log" ]]; then
        echo "1"
    fi
}

function git_dirty() {
# If the git status has *any* changes (e.g. dirty), echo our character
if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then
    echo "*"
fi
}



function is_on_git() {
git rev-parse 2> /dev/null
}

function git_ahead_behind() {
branch_ahead="$(parse_git_ahead)"
branch_behind="$(parse_git_behind)"

}
function parse_git_dirty() {
# If the git status has *any* changes (e.g. dirty), echo our character
if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then
    echo 1
fi
}

function get_git_status() {
# Grab the git dirty and git behind
dirty_branch="$(parse_git_dirty)"
branch_ahead="$(parse_git_ahead)"
branch_behind="$(parse_git_behind)"

#echo "$dirty_branch -- $branch_ahead -- $branch_behind"
# Iterate through all the cases and if it matches, then echo
if [[ "$dirty_branch" == 1 && "$branch_ahead" == 1 && "$branch_behind" == 1 ]]; then
    echo "==*"
elif [[ "$dirty_branch" == 1 && "$branch_ahead" == 1 ]]; then
    echo "->*"
elif [[ "$dirty_branch" == 1 && "$branch_behind" == 1 ]]; then
    echo "<-*"
elif [[ "$branch_ahead" == 1 && "$branch_behind" == 1 ]]; then
    echo "??"
elif [[ "$branch_ahead" == 1 ]]; then
    echo "->"
elif [[ "$branch_behind" == 1 ]]; then
    echo "<-"
elif [[ "$dirty_branch" == 1 ]]; then
    echo "==*"
elif [[ 1 ]]; then
    echo "=="
fi
}

get_git_info () {
    # Grab the branch
    branch="$(get_git_branch)"

    # If there are any branches
    if [[ "$branch" != "" ]]; then
        # Echo the branch
        output="$branch"

        # Add on the git status
        output="$output$(get_git_status)"

        # Echo our output
        echo "$output"
    fi
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
			color_my_prompt

#<original>PS1="\[\033[01;37m\]\$? \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\];)\"; else echo \"\[\033[01;31m\];(\"; fi) $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\h'; fi)\[\033[01;34m\] \W \$\[\033[00m\] "
#mine v simple with last dir only 
#PS1="\h[\W]$ "
#PS1='[\u@\h \W]\$ '  # To leave the default one
#PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\] '

