#!/bin/bash

COUNT=0
BONNE_REPONSE=0

while [ "$COUNT" -lt 15 ]
do
    ./monty.sh

    if [ "$?" -eq 0 ]; then
        BONNE_REPONSE=$((BONNE_REPONSE + 1))
    fi

    COUNT=$((COUNT + 1))

    percent=$(bc <<< "scale=2;$BONNE_REPONSE / $COUNT * 100")

    echo "$COUNT parties jouées, $BONNE_REPONSE bonnes réponses : $percent%"
done