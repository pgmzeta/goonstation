#!/bin/bash
set -euo pipefail

exit_code = 0

# setup
mkdir ./tmp
cp ./code/modules/sound/soundCache.dm ./tmp/soundCache.dm

# action
cd ./tools # has to be run from tools folder :o)
./buildSoundList.ps1

# validation
if diff -q ./code/modules/sound/soundCache.dm ./tmp/soundCache.dm
	echo "ERROR: Sound cache not up to date: to fix, go into the tools folder and run buildSoundList.ps1"
	exit_code = 1
fi

# cleanup
cd .. # back to starting folder
rm ./tmp

exit $exit_code