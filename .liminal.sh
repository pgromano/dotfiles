_liminal-init-check() {
    if ! [ -d $HOME/.liminal ]; then
        echo "Initializing environment repo at $HOME/.liminal"
        mkdir $HOME/.liminal
    fi

    pyver=$(python3 --version)
    if ! [ -d "$HOME/.liminal/$pyver" ]; then
        echo "Initializing version folder at $HOME/.liminal for $pyver"
        mkdir "$HOME/.liminal/$pyver"
    fi
    return 0
}

liminal-help() {
    echo "\nUsage:\n  liminal <command> [options]"
    echo "\nCommands:"
    echo "    help           Show this help message and exit"
    echo "    list           List all existing virtual environments"
    echo "    activate       Activates an existing virtual environment"
    echo "    new            Create a new virtual environment"
    echo "    remove         Remove an existing virtual environment"
}

liminal-list() {
    pyver=$(python3 --version)
    for value in $(ls -d "$HOME/.liminal/$pyver/*/"); do
        echo "[$(basename $value)] - ${value}"
    done
    return 0
}

liminal-activate() {

    pyver=$(python3 --version)
    if ! [ -d "$HOME/.liminal/$pyver/$1" ]; then
        echo "FAIL: Environment $1 does not exists!"
        return 1
    fi
    source "$HOME/.liminal/$pyver/$1/bin/activate"
    return 0
}

liminal-new() {

    pyver=$(python3 --version)
    if [ -d "$HOME/.liminal/$pyver/$1" ]; then
        echo "FAIL: Environment $1 already exists!"
        return 1
    fi
    
    python3 -m venv "$HOME/.liminal/$pyver/$1"
    source "$HOME/.liminal/$pyver/$1/bin/activate"
    pip install --upgrade pip ipykernel ipython
    python -m ipykernel install --user --name $1 --display-name "$1 ($pyver)"
}

liminal-remove() {

    pyver=$(python3 --version)
    if ! [ -d "$HOME/.liminal/$pyver/$1" ]; then
        echo "FAIL: Environment $1 does not exist!"
        return 1
    fi
    rm -rf "$HOME/.liminal/$pyver/$1"
    return 0
}

liminal() {
    if [ -z $1 ];then
        liminal-help
    elif [ "$1" = "help" ]; then
        liminal-help
    elif [ "$1" = "list" ]; then
        liminal-list
    elif [ "$1" = "activate" ]; then
        liminal-activate $2
    elif [ "$1" = "new" ]; then
        liminal-new $2
    elif [ "$1" = "remove" ]; then
        liminal-remove $2
    else
        echo "FAIL: Unable to interpret liminal method $1"
        return 1
    fi
    return 0
}
