#!/bin/bash
#

call_yad() {
	yad --height=200 --width=200 --center --print-column=2 --hide-column=2 --list --column=PORTE:RD --column=NOM --column=DERRIERE 1 1 "$1" 2 2 "$2" 3 3 "$3" 2>/dev/null #1 1 unknow 2 2 unknow 3 3 unknow
}

RAND_NUM_VEHICULE="$((RANDOM % 3 + 1))"
RAND_NUM_CHEVRE=$((RANDOM % 2 + 1)) # première ou dernière porte avec chèvre

ROW_NUM_1="unknow"
ROW_NUM_2="unknow"
ROW_NUM_3="unknow"

# premier appel pour connaître le choix utilisateur
choix=$(call_yad "$ROW_NUM_1" "$ROW_NUM_2" "$ROW_NUM_3")

if [ -z "$choix" ]; then
	echo "choix est empty, fin du programe"
	exit 1
fi

choix="${choix:0:1}" # on prend le premier caractère

# echo "tu as choisi $choix"

PORTE_A_DEVOILER="123"
PORTE_A_DEVOILER="${PORTE_A_DEVOILER/$choix}" # on supprime le choix de l'utilisateur
PORTE_A_DEVOILER="${PORTE_A_DEVOILER/$RAND_NUM_VEHICULE}" # on supprime la porte où il y a le véhicule

# echo "le véhicule est derrière la porte $RAND_NUM_VEHICULE"

# dans tous les cas choisir une porte avec une chèvre
if [ "$RAND_NUM_CHEVRE" -eq 1 ]; then
	# echo "choisir la première porte avec la chèvre"
	PORTE_A_DEVOILER="${PORTE_A_DEVOILER:0:1}"
else
	# echo "choisir la dernière porte avec la chèvre"
	PORTE_A_DEVOILER="${PORTE_A_DEVOILER: -1}" # c'est moche
fi

# echo "la porte à dévoiler est $PORTE_A_DEVOILER"

if [ "$PORTE_A_DEVOILER" -eq 1 ]; then
	ROW_NUM_1="chèvre"
elif [ "$PORTE_A_DEVOILER" -eq 2 ]; then
	ROW_NUM_2="chèvre"
else
	ROW_NUM_3="chèvre"
fi
# premier appel pour connaître le choix utilisateur
choix=$(call_yad "$ROW_NUM_1" "$ROW_NUM_2" "$ROW_NUM_3")

if [ -z "$choix" ]; then
	echo "Aucun choix, c'est mal"
	exit 1
fi

choix="${choix:0:1}"

if [ "$choix" -eq "$RAND_NUM_VEHICULE" ]; then
	echo "c'est gagné"
	exit 0
else
	echo "c'est perdu"
	exit 2
fi