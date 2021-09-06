# alias to allow source refresh regardless of shell
if [ "$SHELL" = "/bin/zsh" ];then
    alias refresh="source ~/.zshrc"
elif [ "$SHELL" = "/bin/bash" ];then
    alias refresh="source ~/.bash_profile"
fi

# automatically expand all aliases
alias -g '$= '

# change sudo based on your mood :sunglasses:
alias please="sudo "
alias fucking="sudo "

# may be more verbose, but sometimes full sentences are cool :sunglasses:
alias copy="cp -R"
alias move="mv"
alias remove="rm -r"

edit() {
    if [ -z $2 ]; then
        vim $1
    elif [ "$1" = "python" ]; then
        vim $2.py
    elif [ "$1" = "markdown" ]; then
        vim $2.md
    elif [ "$1" = "json" ]; then
        vim $2.json
    elif [ "$1" = "yaml" ]; then
        vim $2.yaml
    else
        echo "Unable to interpret file type `$1`"
    fi
}

list() {
    if [ -z $1 ]; then
        # default behavior of list that's being aliased
        ls -lhG $2
    elif [ "$1" = "all" ]; then
        # if `all` then show both hidden and regular files/folders
        ls -lahG $2
    elif [ "$1" = "folders" ]; then
        # folders filters the output of list to folders only
        # handles instances when a folder pattern is and is not passed
        if [ -z $2 ]; then
            ls -ldG */
        else
            ls -ldG $2/*/
        fi
    elif [ "$1" = "files" ]; then
        # files filters the output of list to files only
        # handles instances when a file pattern is and is not passed
        if [ -z $2 ]; then
            ls -lhpG | grep -v /
        else
            ls -lhpG $2 | grep -v /
        fi
    elif [ "$1" = "hidden" ]; then
        # hidden filters the output of list to hidden files/folders only
        # handles instances when a file/folder pattern is and is not passed
        if [ -z $2 ]; then
            ls -lahdG .*
        elif [ "$2" = "files" ]; then
            if [ -z $3 ]; then
                ls -lahpdG .* | grep -v '^.*/$'
            else
                ls -lahpdG $3/.* | grep -v '^.*/$'
            fi
        elif [ "$2" = "folders" ]; then
            if [ -z $3 ]; then
                ls -lahdG .*/
            else
                ls -lahdG $3/.*/
            fi
        else
            ls -lahdG $2/.*
        fi
    else
        # this is an extension of the first instance (i.e. default alias) but
        # when a file/folder pattern is passed by the user
        if [ -z $2 ]; then
            ls -lhG $1
        else
            echo "Unable to interpret command `list $1 $2`"
        fi
    fi
}

new() {
    if [ "$1" = "file" ]; then
        touch $2
    elif [ "$1" = "folder" ]; then
        mkdir $2
    else
        echo "Unable to interpret command `new $1`"
        return 1
    fi
}

# python's virtual env system is a mess, let's use aliases to simplify
file-exists() {
    if [ -f "$1" ]; then
        return 0
    fi
    return 1
}

folder-exists() {
    if [ -d "$1" ]; then
        return 0
    fi 
    return 1
}
