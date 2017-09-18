#!/bin/bash

BASE_ROBOT_REPO=https://github.com/SouthEugeneRoboticsTeam/Robot-Base
ROBOT_PATH=$1
GAME_NAME=$(echo $2 | tr "[:upper:]" "[:lower:]") 

git clone -q --depth=1 $BASE_ROBOT_REPO $ROBOT_PATH

cd $ROBOT_PATH

rm -rf .git

sed -i "" "s/org\.sert2521\.gamename\.Robot/org\.sert2521\.$GAME_NAME\.Robot/g" build.gradle

find src -type f -print0 | xargs -0 sed -i "" "s/org\.sert2521\.gamename/org\.sert2521\.$GAME_NAME/"

mv src/main/java/org/sert2521/gamename src/main/java/org/sert2521/$GAME_NAME
mv src/test/java/org/sert2521/gamename src/test/java/org/sert2521/$GAME_NAME

git init -q
git add . > /dev/null
git commit -q -m "Initial commit"

echo "Robot creation complete!"
echo "Use \`git remote add origin <repo_url>\`, then push to GitHub."
