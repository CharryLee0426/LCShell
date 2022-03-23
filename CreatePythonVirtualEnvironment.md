# Create Python Virtual Environment

## 0. Brief Introduction
This is a develop documentation about the further features of `createPyEnv.sh`.
It can:
* Create a Python virtual environment in your declared directory;
* Check prerequesties automatically;
* Install prerequesties automatially;
* Add pip config in China mainland.

## 1. Usage

For first time, you must give the execution permission to `createPyVenv.sh`.

```bash
# Assumed that you are in the correct directory.

chmod 744 createPyVenv.sh
```

There are 3 options:
* `-v` or `--version`: show the shell script's stable version;
* `-d` or `--directory`: declare a directory where you want to build Python virtual environment;
* `-h` or `--help`: show the usage of the shell script in the terminal.

If you give wrong options or wrong directory, the script will give you an error message.

## 2. Compatibility
The shell supports macOS ,Ubuntu, Debian and other releases which use `apt` package manager.

**CentOS, openSUSE and other releases which use `rpm` package manager can't make sure their compatibility.**
> stable version: in version 1.0.0, I tested `environmentLinuxCheck` function and make sure that you can get apt
and run this script correctly.

**~Can not run on Windows.~**

## 3. Bugs Have Found

1. ~~two lines useless info when there is no param~~.
    ```bash
    # /usr/bin/zsh
    $ pev

    /Users/lichen/GitRepos/LCshell/createPyVenv.sh: line 68: [: too many arguments
    /Users/lichen/GitRepos/LCshell/createPyVenv.sh: line 71: [: too many arguments
    usage:
    pev <option> [directory]
    -v --version
    -h --help
    -d --directory
    ```
2. Bug at line 96
    ```bash
    # ...
    shellPATH=`pwd`
    # ...
    ```
    When running this script every time at different path, shellPATH will be different. Therefore, the script will add additional and incorrect alias information at $HOME/.zshrc or $HOME/.bashrc.
    Maybe it won't effect the pev command run correctly for the reason that the bash or zsh ignores additional alias settings about command pev. But there is also necessary to fix it in further version.

## 4. More Need To Do
1. ~More test in different Operation Systems. Both macOS and Ubuntu are OK~;
2. [**Blocked**] ~~Change the way that make the simple command `pev` available (alias ➡️ $PATH)~~;
3. ~Add the feature that users can change the folder name of Python virtual environment.~
