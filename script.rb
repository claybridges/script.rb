#!/usr/bin/env bash

# Usage: script.rb new-project
# Generates a new script.rb project in the directory specified.
#
# Note: in a break with convention, this file has a .rb "extension", but is actually
# a shell script. This is because the name of this _utility_ is script.rb, and the name
# of this shell script is echoing that.

# for colored output, if applicable
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echoError() {
  echo "${red}ERROR: $1${reset}" >&2
}

if [ "$#" -ne 1 ]; then
  script="$(basename "$0")"
  echoError "single argument required" 
  echo >&2
  echo "Usage: $script new-project" >&2
  exit 1
fi

scriptDir="$1"

if [ -d "$scriptDir" ]; then
  echoError "directory $scriptDir already exists"
  exit 1
fi

if ! which brew >&/dev/null; then
  echoError "This script requires brew. See https://brew.sh for installation instructions."
  exit 1
fi

# Makes sure we have realpath installed, so we can use it to get thisPath
if ! which realpath >&/dev/null; then
  echo "Installing coreutils/realpath"
  brew install coreutils >&/dev/null
fi

thisFile="$0"
thisPath="$( dirname "`realpath "$thisFile"`" )"
cp -R "$thisPath/template" "$scriptDir"
echo "${green}New script.rb project generated at $scriptDir${reset}"