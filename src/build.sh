#!/bin/bash

if [ ! $1 ]; then
    echo "Please enter a 16-character two-step authorization key: "
        read -e -i "$SEED" -p "MFA auth key: " SEED_INPUT
    SEED="${SEED_INPUT:-$SEED}"
else
    set -- "$1" "$SEED"
fi

#echo "$1"
#echo "$SEED"

if [ ! -d google-authenticator ]; then
    https://github.com/google/google-authenticator
else
    #(cd google-authenticator; git pull)
    git pull
fi

if [ -e gmd-cmd.o ]
then
    rm gmd-cmd.o
fi

make all KEY="$(echo -e "$SEED" | tr '[A-Z]' '[a-z]')"