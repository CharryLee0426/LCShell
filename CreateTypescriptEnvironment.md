# Create Typescript Environment

## 0. Brief Introduction
This is a develop documentation about the further features of `createTypescriptEnv.sh`.

## 1. Usage
For first time, you must give the execution permission to `createTypescriptEnv.sh`.

```bash
# Assumed that you are in the correct directory
chmod 744 createTypescriptEnv.sh
```

There are 3 options:

* `-v` or `--version`: show the shell script's stable version;
* `-d` or `--directory`: declare a directory where you want to build Typescript environment;
* `-h` or `--help`:  show the help information;

If you give wrong options or wrong directory, the script will give you an error message.

## 2. Compatibility
The shell supports macOS, Ubuntu, Debian and other releases which use `apt` package manager.

**CentOS, openSUSE and other releases which use `rpm` package manager can't make sure their compatibility.**
> developing version: it's not stable version and it maybe has some bugs.

**~Cant not run on Windows.~**

## 3. Bugs Have Found

## 4. Workflow Of This Script
1. check the neccessary environment tools (for example: homebrew, tsc, apt and so on);
2. show error tips if the folder in the command does not exist;
3. create `dist` and `src` folders;
4. init the declared folder through tsc;
5. modify the `tsconfig.json`;
6. create an empty `index.ts` in the `src` folder;
7. show further tips.