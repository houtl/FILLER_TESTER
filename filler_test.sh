rm -rf /tmp/filler_tester
rm -rf /tmp/filler_resources
git clone https://github.com/houtl/filler_tester.git /tmp/filler_tester
make -C /tmp/filler_tester
git clone https://github.com/houtl/filler.git /tmp/filler_resources
cp -R /tmp/filler_resources/resources .
cp /tmp/filler_tester/filler_tester ./resources
rm -rf /tmp/filler_tester
rm -rf /tmp/filler_resources
red="\033[0;31m"
green="\033[0;32m"
blue="\033[0;34m"
nocolor="\033[0m"
if [ -e "auteur" ]; then
	PLAYER=$(cat auteur)
elif [ -e "author" ]; then
	PLAYER=$(cat author)
else
	echo $red
	echo "Ne peut pas trouver$blue FICHIER AUTEUR$red, verifier bien que vous etes bien dans la racine de depot"
	echo $nocolor
	exit
fi
if [ -e "$PLAYER.filler" ]; then
	cp "$PLAYER.filler" ./resources/players
else
	make re 1>/dev/null 2>&1
	if [ -e "$PLAYER.filler" ]; then
		cp "$PLAYER.filler" ./resources/players
	else
		echo $red
		echo "Ne peut pas trouver$blue $PLAYER.filler$red, verifier que vous etes bien dans la racine de depot"
		echo $nocolor
		exit
	fi
fi
cd resources
./filler_tester << EOF
$PLAYER
y
5
y
5
EOF
rm -rf ./resources/players/"$PLAYER.filler"
rm -rf ./resources/filler_tester
rm -rf ./resources/filler.trace
