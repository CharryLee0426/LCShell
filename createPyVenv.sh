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

version="1.0.0"
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
        sudo apt-get install python3
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
             source $directory/$venvPATH/bin/activate"
    echo "🔔 You can use deactivate to stop the virtual environment."
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
        echo "❌ Error: missing declared directory."
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
                    echo "🤗 You can use it by command pev after restart your terminal."
                fi
            else
                zshrc=`cat ~/.zshrc`
                if [[ "$zshrc" != *"pev=${shellPATH}/createPyVenv.sh"* ]]
                then
                    echo "
                # added by createPyVenv.sh
                alias pev=${shellPATH}/createPyVenv.sh" >> ~/.zshrc
                    echo "🤗 You can use it by command pev after restart your terminal."
                fi
            fi
        else
            echo "❌ Error: directory doesn't existed."
        fi
    fi
else
    echo "$helpINFO"
fi