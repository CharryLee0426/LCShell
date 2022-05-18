# /usr/bin/zsh or /usr/bin/bash
# Both are OK.
# @author: CharryLee
# @date: 2022-05-18
# @description: Create a Typescript environment
#               in your current directory or your
#               declared directory.
# @bug:
#       1. The tsconfig.json isn't created correctly;

###################### #Color Text Setting ################################
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
###########################################################################

version="0.1.3"
options="$1"
directory="$2"
OSVersion=`uname`
typescriptPATH=`which tsc`
venvPATH="virtualEnvironment"
brewPATH=`which brew`
aptPATH=`which apt`
shellPATH=`pwd`
helpINFO="usage:
tev <option> [directory]
-v --version
-h --help
-d --directory"

environmentLinuxCheck () {
    if [ -z $typescriptPATH ]
    then
        echo "⚠️ Your computer does not have typescript"
        sudo apt-get install nodejs
        sudo npm install -g typescript
        echo "✅ typescript has been installed"
    else
        echo "✅Environment Checked OK"
    fi
}

environmentMacOSCheck () {
    if [ -z $typescriptPATH ]
    then
        echo "⚠️ Your computer does not have typescript."
        if [ -z $brewPATH ]
        then
            echo "⚠️Your computer does not have brew."
            -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo "✅ Brew has been installed."
        fi
        brew install node
        sudo npm install -g typescript
        echo "✅ typescript has been installed."
    else
        echo "✅ Environment Checked OK"
    fi
}

buildVirtualEnvironment () {
    echo "🔧 Creating virtual environment"
    mkdir dist
    mkdir src
    tsc --init
    touch tsconfig_old.json
    cat tsconfig.json > tsconfig_old.json
    echo "{
  \"compilerOptions\": {
    \"target\": \"es2016\",                                  /* Set the JavaScript language version for emitted JavaScript and include compatible library declarations. */
    \"module\": \"commonjs\",                                /* Specify what module code is generated. */
    \"rootDir\": \"./src\",                                  /* Specify the root folder within your source files. */
    \"removeComments\": true,                              /* Disable emitting comments. */
    \"esModuleInterop\": true,                             /* Emit additional JavaScript to ease support for importing CommonJS modules. This enables `allowSyntheticDefaultImports` for type compatibility. */
    \"forceConsistentCasingInFileNames\": true,            /* Ensure that casing is correct in imports. */
    \"strict\": true,                                      /* Enable all strict type-checking options. */
    \"skipLibCheck\": true                                 /* Skip type checking all .d.ts files. */
  }
}" > tsconfig.json
    cd src
    touch index.ts
}

if [ $options = "-v" -o $options = "--version" ]
then
    echo "$version"
elif [ $options = "-d" -o $options = "--directory" ]
then
    if [ $version = "Darwin" ]
    then
        environmentMacOSCheck
    else
        environmentLinuxCheck
    fi

    if [ -z $directory ]
    then
        echo "❌ $Red Error $Color_Off: missing declared directory."
    else
        dirInfo = `cd $directory`
        if [ -z $dirInfo ]
        then
            cd $directory
            buildVirtualEnvironment
        else
            echo "❌ Error: directory doesn't existed."
        fi
    fi
else
    echo "$helpINFO"
fi