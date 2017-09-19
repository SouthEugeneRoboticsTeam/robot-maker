# Robot Maker

Robot Maker is a tiny command line utility that makes creating yearly
game repositories super easy. It bases the new code off of the
[Robot-Base](https://github.com/SouthEugeneRoboticsTeam/Robot-Base)
repository and updates everything that needs to be changed. All you
have to do is push the code!

## Installation

If you use Robot Maker often enough to want it installed globally,
copy the `robot-maker.sh` file to `/usr/local/bin/robot-maker`.

```bash
$ cp robot-maker.sh /usr/local/bin/robot-maker
```

Now you can use Robot Maker everywhere!

## Usage

```bash
$ robot-maker <path> <game_name>
```

For example...

```bash
$ robot-maker ../PowerUp-2018 PowerUp
```

This command will create a new git-initialized directory with all the
robot code you'll need to get started.
