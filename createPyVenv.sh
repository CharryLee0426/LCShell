# /bin/bash or /bin/zsh
# Both are OK.
# @author:  CharryLee
# @date:    2022-03-20
# @description: Create a python virtual environment
#               in your current directory or your
#               declared directory.
# @bug:         1. two lines useless info without argument;
#               2. linux environment conflict: need python 3.8 or later;
#               3. macOS environment conflict: can't assume zsh as default;
#               4. tips grammar wrong;

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

version="1.1.0"
options="$1"
directory="$2"
OSVersion=`uname`
pythonPATH=`which python3`
venvPATH="vitualEnvironment"
brewPATH=`which brew`
aptPATH=`which apt`
shellPATH=`pwd`
helpINFO="usage:
pev <option> [directory]
-v --version
-h --help
-d --directory"

environmentLinuxCheck () {
    if [ -z $pythonPATH ]
    then
        echo "⚠️ Your computer does not have Python3"
        sudo apt-get install python3=3.8.2
        echo "✅ Python3 has been installed"
    else
        echo "✅ Environment Checked OK"
    fi
}

environmentMacOSCheck () {
    if [ -z $pythonPATH ]
    then
        echo "⚠️ Your computer does not have Python3."
        if [ -z $brewPATH ]
        then
            echo "⚠️Your computer does not have brew."
            -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo "✅ Brew has been installed."
        fi
        brew install python@3.8
        echo "✅ Python3 has been installed."
    else
        echo "✅ Environment Checked OK"
    fi
}

buildVirtualEnvironment () {
    echo "Enter your virtual environment name:"
    read venvPATH
    echo "🔧 Creating virtual environment..."
    python3 -m venv $venvPATH
    echo "✅ Virtual environment created."
    echo "🔧 Adding pip config file..."
    touch ./$venvPATH/pip.conf
    echo "[global]
index-url = https://mirrors.aliyun.com/pypi/simple
[install]
trusted-host = mirrors.aliyun.com" >> ./$venvPATH/pip.conf
    chmod 444 ./$venvPATH/pip.conf
    echo "✅ pip.conf created."
    echo "🍺 virtual environment starting..."
    echo "🎉 virtual envirmonment started..."
    echo "🔔 You can start virtual environment by 

             $Green source $directory/$venvPATH/bin/activate $Color_Off

"
    echo "🔔 You can use $Red deactivate $Color_Off to stop the virtual environment."
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
        dirInfo=`cd $directory`
        if [ -z $dirInfo ]
        then
            cd $directory
            buildVirtualEnvironment
            if [ $OSVersion = "Linux" ]
            then
                bashrc=`cat ~/.bashrc`
                if [[ "$bashrc" != *"pev=${shellPATH}/createPyVenv.sh"* ]]
                then
                    echo "
                # added by createPyVenv.sh
                alias pev=${shellPATH}/createPyVenv.sh" >> ~/.bashrc
                    echo "🤗 You can use it by command $Yellow pev $Color_Off after restart your terminal."
                fi
            else
                zshrc=`cat ~/.zshrc`
                if [[ "$zshrc" != *"pev=${shellPATH}/createPyVenv.sh"* ]]
                then
                    echo "
                # added by createPyVenv.sh
                alias pev=${shellPATH}/createPyVenv.sh" >> ~/.zshrc
                    echo "🤗 You can use it by command $Yellow pev $Color_Off after restart your terminal."
                fi
            fi
        else
            echo "❌ Error: directory doesn't existed."
        fi
    fi
else
    echo "$helpINFO"
fi