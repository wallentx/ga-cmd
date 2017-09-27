#!/bin/bash

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        if grep -q 'PATH=$PATH:$HOME/bin' $HOME/.bash_profile; then
            echo $HOME'/bin already added to PATH.'
            echo 'Reload your terminal, or source '$HOME'/.bash_profile'
        else
            echo -e 'PATH=$PATH:$HOME/bin' >> "$HOME/.bash_profile"
            echo 'PATH=$PATH:$HOME/bin has been added to '$HOME'/.bash_profile.'
            echo 'Reload your terminal, or source '$HOME'/.bash_profile'
        fi
    fi
}

    if [ ! $1 ]; then
        echo "Please enter a 16-character two-step authorization key: "
            read -e -i "$SEED" -p "MFA auth key: " SEED_INPUT
            SEED="${SEED_INPUT:-$SEED}"
    else
        set -- "$1" "$SEED"
    fi

    if [ ! -d google-authenticator ]; then
        git clone https://github.com/google/google-authenticator
    else
        #(cd google-authenticator; git pull)
        git pull
    fi

    if [ -e gmd-cmd.o ]; then
        rm gmd-cmd.o
    fi

make all KEY="$(echo -e "$SEED" | tr '[A-Z]' '[a-z]')"

    if [[ -d $HOME/bin ]]; then
        ln -s src/bin/ga-cmd $HOME/bin/ga-cmd
        echo -e "ga-cmd has been symlinked to $HOME/bin/ga-cmd"
    fi

    if [[ :$PATH: == *:"$HOME/bin":* ]] ; then
        exit 0
    else
        echo -e "$HOME/bin exists, but is not added to PATH. Would you like to add it?"
        read -p "Add $HOME/bin to PATH? [y/n] " -n 1 -r REPLY
            echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            pathadd $HOME/bin
            exit 0
        else
            [[ $REPLY =~ ^[Nn]$ ]]
            exit 0
        fi
    fi