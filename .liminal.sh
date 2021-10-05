_liminal-init-check() {
    if ! folder-exists $HOME/.liminal; then
        echo "Initializing environment repo at $HOME/.liminal"
        mkdir $HOME/.liminal
    fi
    return 0
}

liminal-help() {
    echo "\nUsage:\n  liminal <command> [options]"
    echo "\nCommands:"
    echo "  help\t\tShow this help message and exit"
    echo "  list\t\tList all existing virtual environments"
    echo "  activate\t\tActivates an existing virtual environment"
    echo "  new\t\tCreate a new virtual environment"
    echo "  remove\tRemove an existing virtual environment"
}

liminal-list() {
    for value in $(ls -d $HOME/.liminal/*/); do
        echo "[$(basename $value)] - ${value}"
    done
    return 0
}

liminal-activate() {

    if ! folder-exists $HOME/.liminal/$1; then
        echo "FAIL: Environment $1 does not exists!"
        return 1
    fi
    source $HOME/.liminal/$1/bin/activate
    return 0
}

liminal-new() {

    if folder-exists $HOME/.liminal/$1; then
        echo "FAIL: Environment $1 already exists!"
        return 1
    fi
    python3 -m venv $HOME/.liminal/$1
    source $HOME/.liminal/$1/bin/activate
    pip install --upgrade pip ipykernel ipython
    python -m ipykernel install --user --name $1 --display-name "$1 ($(python --version))"
}

liminal-remove() {

    if ! folder-exists $HOME/.liminal/$1; then
        echo "FAIL: Environment $1 does not exist!"
        return 1
    fi
    rm -rf $HOME/.liminal/$1
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
