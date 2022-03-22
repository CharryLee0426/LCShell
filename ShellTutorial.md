# Shell Introduction

## 0. What's Shell?
> In computing, a shell is a computer program which exposes an operating system's services to a human user or other programs. In general, operating system shells use either a command-line interface (CLI) or graphical user interface (GUI), depending on a computer's role and particular operation. It is named a shell because it is the outermost layer around the operating system.

The above is a concept given by Wikipedia. Ususally, we talk about shell as a command-line interface which is usually in your system default. The famous shells in your system (I assume that you have a Unix or Unix-like system) are bash, zsh and k-sh. All the shells follow a similar standard and shell script can be run correctly in all the shells. Shell can make your work more efficently because your can write script to do your routine thing. Therefore, it's very helpful for you to learn the basic knowledge about shell script.

## 1. Shell Script

### 1.1 `Hello World` Script

There is the easiest script that you can understand the most basic of shell script.

```bash
# /bin/bash or /bin/zsh
# Both are OK.

echo "What's your name?"
read Person
echo "Hello, $Person."
```

You can save it as `test.sh`. However, in most modern systems, you cannot run this script directly because the script doesn't have the execution permission.

You can go to the folder where the shell script lives, and use `ls -l` to see the detail of file. You can see the following:

```bash
-rw-r--r--  1 lichen  staff    83  3 12 00:20 test.sh
```

For most users, you just need to give the permission, run this command to make it execute.

```bash
chomd 744 test.sh # test.sh can be replaced by your filename
```

Then you can use `./test.sh` ro run this script.

In this script, you see two simple commands: `echo` and `read`. `echo` can output something to the STDOUT (by default). `read` can accept your input in the terminal to the variable `Person`. When you want to use the variable `Person`, you must add `$` ahead.

### 1.2 Variable
A variable is a character string to which we assign a value. The value assigned could be a number, text, filename, device, or any other type of data. It's nothing more than a pointer to the actual data. The shell enables you to create, assign and delete variables.

The name of a variable can contain only letters (a to z or A to Z), numbers ( 0 to 9) or the underscore character ( _). By convention, Unix shell variables will have their name in UPPERCASE.

These are valid variable names:

```bash
_ALI
TOKEN_A
VAR_1
VAR_2
```

These are invalid variable names:

```bash
2_VAR           # numbers should not be the first
-VARIABLE       # can't use dash symbol (-)
VAR1-VAR2
VAR_A!          # can't use exclamation mark (!)
```

You can define a variable using:

```bash
variableName=variableValue
```

Shell also support define a const, but don't have a specific keyword like `const`. You can use `readonly` keyword to declare a variable that it cannot be changed after initialization. Look at this example:

```bash
NAME="Charry"
readonly NAME
NAME="Lee"      # this will cause an ERROR
echo "$NAME"
```

When you execute this script, you will see that error info:

```shell
❯ ./test.sh
./test.sh: line 3: NAME: readonly variable
```

Like python or javascript, you can delete variables to make them not available after deleting. `unset` command is used to delete a variable. However, `unset` command can not delete variable which are marked `readonly`. See the following example:

```bash
NAME="Charry"
LASTNAME="Lee"
readonly LASTNAME
unset NAME
unset LASTNAME      # this will cause an ERROR
```

For users, there are 3 types of variables:
* **Local Variable** A local variable is a variable that is present within the current instance of the shell. It is not available to programs that are started by the shell. They are set at the command prompt.
* **Environment Variable** An environment variable is available to any child process of the shell. Some programs need environment variables in order to function correctly. Usually, a shell script defines only those environment variables that are needed by the programs that it runs.
* **Shell Variable** A shell variable is a special variable that is set by the shell and is required by the shell in order to function correctly. Some of these variables are environment variables whereas others are local variables.

### 1.3 Special Variable
There are some special variables in Unix which are declared by default (these are the same in Linux).

| Variable | Description                                                  |
| -------- | ------------------------------------------------------------ |
| **$0**   | The filename of the current script.                          |
| **$n**   | These variables correspond to the arguments with which a script was invoked. Here **n** is a positive decimal number corresponding to the position of an argument (the first argument is \$1, the second argument is \$2, and so on). |
| **$#**   | The number of arguments supplied to a script.                |
| **$\***  | All the arguments are **double quoted**. If a script receives two arguments, \$* is equivalent to \$1 \$2. |
| **$@**   | All the arguments are individually double quoted. If a script receives two arguments, \$@ is equivalent to \$1 \$2. |
| **$?**   | The exit status of the last command executed.                |
| **$$**   | The process number of the current shell. For shell scripts, this is the process ID under which they are executing. |
| **$!**   | The process number of the last background command.           |

You must found that \$* and \$@ is very similar. However, there is a slight difference between them. See this example.

```bash
# filename: cmd.sh
# /bin/bash or /bin/zsh
# Both are OK.

echo "Printing \$* "
for i in $*
do
        echo i is: $i
done

echo "Printing \$@ "
for i in "$@"
do
        echo i is: $i
done
```

Execute this script by add these following arguments:

```shell
$ ./cmd a b "c d" e
Printing $*
i is: a
i is: b
i is: c
i is: d
i is: e
Printing $@
i is: a
i is: b
i is: c d
i is: e
```

When you pass the command line argument in double quotes ("c d"), the \$* does not consider them as a single entity, and splits them. However, the \$@ considers them as a single entity and hence the 3rd echo statement shows "c d" together. This is the difference between \$* and \$@.

These special variables are very helpful for users and you should learn how to use them wisely.

### 1.4 Using Array
A shell variable is capable enough to hold a single value. These variables are called scalar variables.

Shell supports a different type of variable called an **array** variable. This can hold multiple values at the same time. Arrays provide a method of grouping a set of variables. Instead of creating a new name for each variable that is required, you can use a single array variable that stores all the other variables.

There is one point that you must pay attention to. It's different to declare an array in ksh or bash (zsh).

If you declare an array in ksh, you should use this syntax:

```ksh
set -A array_name value1 value2 ... valuen
```

If you declare an array in bash (zsh), you should use this syntax:

```bash
array_name=(value1 ... valuen)
```

> WARNING: the shell does not ignore the space ' '. So don't use space between variable name and variable value. `ARRAY = (value_1 value_2 ... value_n)` will cause an error because the shell can't handle the space symbol.

After you have set any array variable, you access it as following:

```bash
${ARRAYNAME[index]}
```

You can access all the elements in the array by using the following two methods:

```bash
${ARRAYNAME[@]}
${ARRAYNAME[*]}
```

### 1.5 Basic Operators
There are various operators supported by each shell. The following will discuss in detail about bash (default shell).

Like other programming languages, shell has several kinds of operators:
* Arithmetic Operators;
* Relational Operators;
* Boolean Operators;
* String Operators;
* File Test Operators.

#### 1.5.1 Arithmetic Operators
Look at this example and shell has the ability to calculate the expressions you give.

```bash
# /bin/bash or /bin/zsh
# Both are OK.

val=`expr 2 + 2`
echo "Total value : $val"
```

The following points must to be considered:
* There must be spaces between operators and expressions. For example, 2+2 is not correct; it should be written as 2 + 2;
* The complete expression should be enclosed between ‘ ‘, called the backtick.

There are some useful arithmetic operators: `+, -, *, /, %, =, ==, !=`.

All the arithmetical calculations are done using long integers.


#### 1.5.2 Retional Operators
Bash or zsh supports the following relational operators that are specific to numeric values. These operators do not work for string values unless their value is numeric.

For example, following operators will work to check a relation between 10 and 20 as well as in between "10" and "20" but not in between "ten" and "twenty".

`-eq, -ne, -gt, -lt, -ge, -le` are abbreviation of some relation words such as **greater, equal, less**.

#### 1.5.3 Boolean Operators
It also provides some boolean operators for boolean operation such as `!` (reverse), `-a` (and), `-o` (or). For example:

```bash
# Assume that a = 10 and b = 20.

[ $a -lt 20 -o $b -gt 100]      # true
```

#### 1.5.4 String Operators
There are several string operators being used to compare two Strings. Here are all of them.

| Operator | Description                                                  |
| -------- | ------------------------------------------------------------ |
| =        | Checks if the value of two operands are equal or not; if yes, then the condition becomes true. |
| !=       | Checks if the value of two operands are equal or not; if values are not equal then the condition becomes true. |
| -z       | Checks if the given string operand size is zero; if it is zero length, then it returns true. |
| -n       | Checks if the given string operand size is non-zero; if it is nonzero length, then it returns true. |
| str      | Checks if **str** is not the empty string; if it is empty, then it returns false. |

There are two concepts that you should pay attention to: `length=0` and `null`. For shell script or other programming languages, `null` means that the system can not find the string (maybe the string variable doesn't be initialized). `length=0` means that the variable has been initialized but the length is 0.

#### 1.5.5 File Test Operators
File test operators are used to test unix files.

| Operators | Description                                                  |
| --------- | ------------------------------------------------------------ |
| -b        | is block special file?                                       |
| -c        | is character special file?                                   |
| -d        | is directory?                                                |
| -f        | is an ordinary file as opposed to a directory or a special file? |
| -g        | has set group ID (SGID) bit set?                             |
| -k        | has its sticky bit set?                                      |
| -p        | is a named pipe?                                             |
| -t        | is file descriptor open and associated with a terminal?      |
| -u        | has set Set User ID (SUID) bit set?                          |
| -r        | is readable?                                                 |
| -w        | is writable?                                                 |
| -x        | is executable?                                               |
| -s        | is size greater than 0?                                      |
| -e        | is file exists?                                              |

There is a simple demo that shows you how to use these file test operators. The script will check itself if readable, writable and executable.

```bash
# /usr/bin/bash or /usr/bin/bash
# Both are OK.

filePath = "./test.sh"

if [ -r  $filePath ]
then
    echo "$0 is readable"
fi

if [ -w $filePath ]
then
    echo "$0 is writable"
fi

if [ -x $filePath ]
then
    echo "$0 is executable"
fi
```

### 1.6 Decision-Making (Branch Control)
Almost all the shells support decision-making (as known as "if, else, switch, ...") in Unix. When you meet some cases that might be, you will make use of conditional statements that allow your program to make correct decisions and perform the right actions.

There are two decision-making statements here:
* `if...else...`
* `case...esac`

#### 1.6.1 `if...else...`
This is the most complete `if...else...` statement.

```bash
# /usr/bin/bash or /usr/bin/zsh
# Both are OK.

if [ <condition 1> ]
then
        # workflow 1
elif [ <condition 2> ]
then 
        # workflow 2
else
        # workflow 3
fi
```

You can add more `elif...` block to make your script do more things.

#### 1.6.2 `case...esac`

Of course you can use multiple `if...elif` statements to perform a multiway branch. However, this is not the best solution. Especially when all of your branches depend on the value of a single variable. In this situation, you should use `case...esac` to replace multiple `if...elif` in order to make your script efficiently.

```bash
# /usr/bin/bash or /usr/bin/zsh
# Both are OK.
# Assumed that word is a string variable.

case word in
   pattern1)
      # Statement(s) to be executed if pattern1 matches
      ;;
   pattern2)
      # Statement(s) to be executed if pattern2 matches
      ;;
   pattern3)
      # Statement(s) to be executed if pattern3 matches
      ;;
   *)
     # Default condition to be executed
     ;;
esac
```

It's very similar to the `switch...case` statement of other programming languages like `C/C++`.

### 1.7 Loop
The shell script supports 4 types of loops.
* while
* for
* until
* select

You will use different loops based on the situation. For example, the while loop executes the given commands until the given condition remains true; the until loop executes until a given condition becomes true.

#### 1.7.1 while loop

```bash
while command1 ; # this is loop1, the outer loop
do
   Statement(s) to be executed if command1 is true

   while command2 ; # this is loop2, the inner loop
   do
      Statement(s) to be executed if command2 is true
   done

   Statement(s) to be executed if command1 is true
done
```

#### 1.7.2 for loop

```bash
for var in word1 word2 ... wordN
do
   Statement(s) to be executed for every word.
done
```

`word1 word2 ... wordN` can be replaced by an array variable. It's very similar with `for (int number : int[]) {...}` in Java.

#### 1.7.3 until loop

`until` loop is similar with `do...while` loop in C/C++.

```bash
until <condition>
do
        # workflow
done
```

#### 1.7.4 select loop
The select loop provides an easy way to create a numbered menu from which users can select options. It is useful when you need to ask the user to choose one or more items from a list of choices.

```bash
select var in word1 word2 ... wordN
do
   # Statement(s) to be executed for every word.
done
```

See this script. It can help you build a reactive interface.

```bash
select DRINK in tea cofee water juice appe all none
do
   case $DRINK in
      tea|cofee|water|all) 
         echo "Go to canteen"
         ;;
      juice|appe)
         echo "Available at home"
      ;;
      none) 
         break 
      ;;
      *) echo "ERROR: Invalid selection" 
      ;;
   esac
done
```

When you run this script, you will see several with `#?` ahead. You can input the sequence numbers the system gives and go to the sepecific branch. In macOS, you must input the number to select, maybe you should input the variable itself in another OS.

```shell
> ./test.sh
1) tea
2) cofee
3) water
4) juice
5) appe
6) all
7) none
#? none
ERROR: Invalid selection
#? 1
Go to canteen
#? 5
Available at home
#? 7
```

‼️ NOTICE ‼️ Whatever loops you choose to use, please make sure that they are not infinite loops for the reason that any loop must has a limited life and comes out once the conditon is false or true depending on the loop.

### 1.8 Substitution
The shell performs substitution when it encounters an expression that contains one or more special characters. For examples, `\n` means 'newline'.

```bash
a = 10
echo -e "Value of a is $a \n"
```

`-e` option enables the interpretation of backslash escapes. Without this option, `\n` will only be string `\n`.

The following escape sequences which can be used in echo command.

| Escape | Description               |
| ------ | ------------------------- |
| \\\    | backslash                 |
| \a     | alert (BEL)               |
| \b     | backspace                 |
| \c     | suppress trailing newline |
| \f     | form feed                 |
| \n     | new line                  |
| \r     | carriage return           |
| \t     | horizontal tab            |
| \v     | vertical lab              |

Command substitution is the mechanism by which the shell performs a given set of commands and then substitutes their output in the place of the commands.

The syntax of command substitution is:

```bash
`command`
```

For example:

```bash
DATE=`date`
echo "Date is $DATE"
```

When you run this script, the system will replace `$DATE` by the result of command `date`.

Variable substitution iis the mechanism by which the shell can replaced some variables.

| variable substitution | description                                                  |
| --------------------- | ------------------------------------------------------------ |
| ${var}                | substitute the value of var                                  |
| ${var:-word}          | If var is null or unset, word is substituted for var. The value of var doesn't change. |
| ${var:=word}          | If var is null or unset, var is set to the value of **word**. |
| ${var:?message}       | If var is null or unset, message is printed to standard error. This checks that variables are set correctly. |
| ${var:+word}          | If var is set, word is substituted for var. The value of var doesn't change. |

### 1.9 IO Redirection
Most Unix system commands take input from your terminal and send the resulting output back to your terminal. A command normally reads its input from the standard input, which happens to be your terminal by default. Similarly, a command normally writes its output to standard output, which is again your terminal by default.

#### 1.9.1 Input redirection
The output from a command normally intended for standard output can be easily diverted to a file instead. This capability is known as output redirection. You can use a '>' to change the output destination from your system default terminal screen to another file or pipe.

Look at the example below.

```bash
# /usr/bin/bash or /usr/bin/zsh
# Both are OK.

FILE="directory.txt"
CURRENTFILE=$0
if [ ! -e $FILE ]
then 
    touch $FILE
    echo "this is a file that created by $CURRENTFILE" > $FILE
else
    echo "the file has existed." > $FILE
fi
```

When you excute the script, you won't see any tips in this process. Because the two `echo` commands in this script declare that the result will not send to `stdout`.

There is a point that you must pay attention to is that if a command has its output redirected to a file and the file already contains some data, that data will be **lost**. To protect the content of the file, you can use `>>` to replace `>` in order to append new content but not replace the content of this file.

#### 1.9.2 Output Redirection
Just as the output of a command can be redirected to a file, so can the input of a command be redirected from a file. As the greater-than character `>` is used for output redirection, the less-than character `<` is used to redirect the input of a command.

```bash
# Assumed that users is a text file.

wc -l users    # 2 users
wc -l < users  # 2
```

In the first case, it is reading its input from the file users. In the second case, it only knows that it is reading its input from standard input so it does not display file name.

#### 1.9.3 Here Document
Here Document is used to redirect input into an interactive shell script or program.

You can run an interactive program within a shell script without user action by supplying the required input for the interactive program, or interactive shell script.

The basic syntax of Here Document is:

```bash
command << endstring
# The endstring must be a single word that does not contain spaces or tabs.
```

When you run this, you will go into a `heredoc>` tag. You can input something. When you type `endstring` into terminal and press `enter`, the system will handle your input. You can use the here document to print multiple lines using your script.

```bash
cat << EOF
This is a simple lookup program 
for good (and bad) restaurants
in Cape Town.
EOF
```

#### 1.9.4 Discard Output
Sometimes you will need to execute a command, but you don't want the output displayed on the screen. In such cases, you can discard the output by redirecting it to the file `/dev/null`.

To discard both output of a command and its error output, use standard redirection to redirect `STDERR` to `STDOUT`.

```bash
command > /dev/null 2>&1
```
Here 2 represents `STDERR` and 1 represents `STDOUT`.

### 1.10 Shell Function
Using functions to perform repetitive tasks is an excellent way to create **code reuse**. This is an important part of modern object-oriented programming principles.

Shell functions are similar to subroutines, procedures, and functions in other programming languages.

The syntaxes of defining and invokeing a function which doesn't have a parameter is:

```bash
# /usr/bin/bash or /usr/bin/bash
# Both are OK.

# Define your function here
Hello () {
   echo "Hello World"
}

# Invoke your function
Hello
```
The result is that the terminal will show you a `hello world`.

You can define a function that will accept parameters while calling the function. These parameters would be represented by $1, $2 and so on.

Following is an example where it passes two parameters Zara and Ali and then it captures and prints these parameters in the function.

```bash
# /usr/bin/bash or /usr/bin/zsh
# Both are OK.

# Define your function here
Hello () {
   echo "Hello World $1 $2"
}

# Invoke your function
Hello Zara Ali
```
You can also define a function that has more than 1 parameter. You can define a function that will accept parameters while calling the function. These parameters would be represented by $1, $2 and so on.

Like other programming languages, you can define a function which invokes other funcions or itself. See this example below:

```bash
Func1 () {
   echo "this is function 1."
   Func2
}

Func2 () {
   echo "this is function 2."
}

# Invoke function 1.
Func1
```
The result of the example above is:

```shell
this is function 1.
this is function 2.
```
The behavior that call function itself called **recursive**. There also is a method that you can put definitions for commonly used functions inside your .profile. These definitions will be available whenever you log in and you can use them at the command prompt.

To remove the definition of a function from the shell, use the unset command with the `-f ` option. This command is also used to remove the definition of a variable to the shell.

## 2. Some Tips

### 2.1 Alias V.S. PATH

When I want to solve the problem that shell will add `alias settings` repeatly, I found a possible way like that:

```bash
# Previous operations:
# add "alias pev=..." >> .zshrc(Linux) or .bashrc(macOS)

# My way
pevPATH=`which pev`

if [ -z $pevPATH ]
then
    # add the alias setting to profile.
fi
```

However, it doesn't work. This is because `which` can only locate a program file in the user's path. Usually, your command is a binary file which is located in `/usr/bin` or other paths which are in `$PATH`. Because we can't add this script to the `$PATH` because of the denied permission but create an alias to this script in zsh or bash.

I found another solution. It can just works to check if `.zshrc` or `.bashrc` contains the alias infomation.

### 2.2 How to Find Substring in Shell Script?
That's a possible way to find substring in a file to use `*` regex operators. `*` means that no char or have any chars.

```bash
if [[ "$bashrc" != *"pev=${shellPATH}/createPyVenv.sh"* ]]
then
    # do workflow...
fi
```

The script above will check if `$bashrc` matches `...pev=pev=${shellPATH}/createPyVenv.sh...`. Of course there are not only one way to find substring.