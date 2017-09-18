#!/bin/bash

BASE_ROBOT_REPO=https://github.com/SouthEugeneRoboticsTeam/Robot-Base

print_usage() {
  echo "Usage: robot-maker <path> <game_name>"
}

# Check for `-h` option
if [ "$1" == "-h" ]; then
  print_usage
  exit 0
fi

ROBOT_PATH=$1
GAME_NAME=$(echo $2 | tr "[:upper:]" "[:lower:]") 

# Verify that params are set
if [ -z "$ROBOT_PATH" ] || [ -z "$GAME_NAME" ]; then
  print_usage
  exit 1
fi

# Clone base repository
git clone -q --depth=1 $BASE_ROBOT_REPO $ROBOT_PATH

cd $ROBOT_PATH

# Remove git files
rm -rf .git

# Replace references of base `gamename` with the actual $GAME_NAME
sed -i.bak "s/org\.sert2521\.gamename\.Robot/org\.sert2521\.$GAME_NAME\.Robot/g" build.gradle
find src -type f -print0 | xargs -0 sed -i.bak "s/org\.sert2521\.gamename/org\.sert2521\.$GAME_NAME/g"

# Remove backup files
find . -type f -name "*.bak" -delete

# Rename `gamename` directories to the actual $GAME_NAME
mv src/main/java/org/sert2521/gamename src/main/java/org/sert2521/$GAME_NAME
mv src/test/java/org/sert2521/gamename src/test/java/org/sert2521/$GAME_NAME

git init -q

echo "Robot creation complete!"
echo "Use \`git remote add origin <repo_url>\`, then push to GitHub."
