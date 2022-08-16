alert-init-check() {
    # make sure a base alert directory exists
    if ! [ -d $HOME/.alert ]; then
        echo "Initializing environment repo at $HOME/.alert"
        mkdir $HOME/.alert
        echo "/System/Library/Sounds/Funk.aiff" > $HOME/.alert/default
    fi
}

alert-help() {
    echo "\nUsage:\n  alert <command> [options]"
    echo "\nCommands:"
    echo "    help           Show this help message and exit"
    echo "    list           List all existing virtual environments"
    echo "    activate       Activates an existing virtual environment"
    echo "    deactivate     Deactivates current virtual environment"
    echo "    create         Create a new virtual environment"
    echo "    remove         Remove an existing virtual environment"
    echo "    install        Install a new Python version"
    echo "    uninstall      Uninstall an existing Python version"
    echo "    switch         Switch between existing Python versions"
    echo "    status         Display info about the current active env and Python version"
}


alert-set-sound() {
    sound_path=/System/Library/Sounds/$1.aiff
    if ! [ $sound_path ]; then
        echo "Cannot find audio file for $sound_path"
        return 1
    fi
    echo $sound_path > $HOME/.alert/default
    return 0
}


alert-get-sound() {
    default_sound=$(cat $HOME/.alert/default | xargs -n 1 basename)
    default_sound="${default_sound%%.*}"
}


alert-list-sounds() {
    alert-get-sound
    echo "Available Sounds (default: $default_sound)"
    for value in $(ls -1 /System/Library/Sounds/*.aiff | xargs -n 1 basename); do
        current_sound="${value%%.*}"
        if [ $current_sound = $default_sound ]; then
            echo "  • $current_sound*"
        else
            echo "  • $current_sound"
        fi
    done
}


alert-play-sound() {
    afplay $(cat $HOME/.alert/default) --time 0.1 --volume $1
}


alert-test-sound() {
    afplay /System/Library/Sounds/$1.aiff --time 0.1
}


alert() {
    if [ -z $1 ];then
        alert-play-sound 10
    elif [ "$1" = "soft" ];then
        alert-play-sound 1
    elif [ "$1" = "medium" ];then
        alert-play-sound 10
    elif [ "$1" = "loud" ];then
        alert-play-sound 20
    elif [ "$1" = "blast" ];then
        alert-play-sound 50
    elif [ "$1" = "danger" ];then
        alert-play-sound 100
    elif [ "$1" = "help" ]; then
        alert-help
    elif [ "$1" = "list" ]; then
        alert-list-sounds
    elif [ "$1" = "set" ]; then
        alert-set-sound $2
    elif [ "$1" = "test" ]; then
        alert-test-sound $2
    else
        echo "FAIL: Unable to interpret liminal method $1"
        return 1
    fi
    return 0
}
