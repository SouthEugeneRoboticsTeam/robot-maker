#!/bin/bash

BASE_ROBOT_REPO=https://github.com/SouthEugeneRoboticsTeam/Robot-Base

usage() {
  echo "Usage: $(basename $0) <path>"
}

# Check for `-h` option
if [ "$1" == "-h" ]; then
  usage
  exit 0
fi

ROBOT_PATH=$1

GAME_NAME_FULL=${ROBOT_PATH##*/}
GAME_NAME=${GAME_NAME_FULL%-*}
YEAR=${GAME_NAME_FULL##*-}

GAME_NAME_SM=$(echo $GAME_NAME | tr "[:upper:]" "[:lower:]") 


# Verify that params are set
if [ -z "$ROBOT_PATH" ] || [ -z "$GAME_NAME" ] || [ -z "$YEAR" ]; then
  usage
  exit 1
fi

# Clone base repository
git clone -q --depth=1 $BASE_ROBOT_REPO $ROBOT_PATH

cd $ROBOT_PATH

# Remove git files
rm -rf .git

# Replace references of base `gamename` with the actual $GAME_NAME
sed -i.bak "s/org\.sert2521\.gamename\.Robot/org\.sert2521\.$GAME_NAME_SM\.Robot/g" build.gradle
find src -type f -print0 | xargs -0 sed -i.bak "s/org\.sert2521\.gamename/org\.sert2521\.$GAME_NAME_SM/g"

# Remove backup files
find . -type f -name "*.bak" -delete

# Rename `gamename` directories to the actual $GAME_NAME
mv src/main/java/org/sert2521/gamename src/main/java/org/sert2521/$GAME_NAME_SM
mv src/test/java/org/sert2521/gamename src/test/java/org/sert2521/$GAME_NAME_SM

# Remove README and create new one from README_TEMPLATE
rm README.md
mv README_TEMPLATE.md README.md
sed -i "s/{{name}}/$GAME_NAME/g" README_TEMPLATE.md
sed -i "s/{{name_full}}/$GAME_NAME_FULL/g" README_TEMPLATE.md
sed -i "s/{{year}}/$YEAR/g" README_TEMPLATE.md

git init -q

echo "Robot creation complete!"
echo "Use \`git remote add origin <repo_url>\`, then push to GitHub."
