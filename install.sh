#!/usr/bin/env bash
# shellcheck disable=SC1117,SC2034,SC2154,SC2181

########################################################################################
#
# /$$$$$$ /$$   /$$  /$$$$$$  /$$$$$$$$ /$$$$$$  /$$       /$$       /$$$$$$$$ /$$$$$$$
#|_  $$_/| $$$ | $$ /$$__  $$|__  $$__//$$__  $$| $$      | $$      | $$_____/| $$__  $$
#  | $$  | $$$$| $$| $$  \__/   | $$  | $$  \ $$| $$      | $$      | $$      | $$  \ $$
#  | $$  | $$ $$ $$|  $$$$$$    | $$  | $$$$$$$$| $$      | $$      | $$$$$   | $$$$$$$/
#  | $$  | $$  $$$$ \____  $$   | $$  | $$__  $$| $$      | $$      | $$__/   | $$__  $$
#  | $$  | $$\  $$$ /$$  \ $$   | $$  | $$  | $$| $$      | $$      | $$      | $$  \ $$
# /$$$$$$| $$ \  $$|  $$$$$$/   | $$  | $$  | $$| $$$$$$$$| $$$$$$$$| $$$$$$$$| $$  | $$
#|______/|__/  \__/ \______/    |__/  |__/  |__/|________/|________/|________/|__/  |__/
#
#                            EK UTILITY INSTALLER v1.3.0
#
########################################################################################

NORM=0
BOLD=1
UNLN=4
RED=31
GREEN=32
BROWN=33
BLUE=34
MAG=35
CYAN=36
GREY=37
DARK=90

CL_NORM="\e[${NORM}m"
CL_BOLD="\e[${BOLD}m"
CL_UNLN="\e[${UNLN}m"
CL_RED="\e[${RED}m"
CL_GREEN="\e[${GREEN}m"
CL_BROWN="\e[${BROWN}m"
CL_BLUE="\e[${BLUE}m"
CL_MAG="\e[${MAG}m"
CL_CYAN="\e[${CYAN}m"
CL_GREY="\e[${GREY}m"
CL_DARK="\e[${DARK}m"

################################################################################

OS_LINUX="linux"
OS_SOLARIS="solaris"
OS_BSD="bsd"
OS_MACOSX="macosx"

DIST_ARCH="arch"
DIST_CENTOS="centos"
DIST_DEBIAN="debian"
DIST_FEDORA="fedora"
DIST_GENTOO="gentoo"
DIST_RHEL="rhel"
DIST_UBUNTU="ubuntu"

################################################################################

# List of supported command line options (String)
SUPPORTED_OPTS="no-deps debug yes"

# List of supported short command line options (String)
SHORT_OPTS="n:!no-deps D:!debug y:!yes"

################################################################################

# OS name (String)
os_name=""

# OS arch (String)
os_arch=""

# OS dist (String)
os_dist=""

# Flag will be set to true if some required apps is not installed (Boolean)
requireFailed=""

# Script directory (String)
script_dir=$(dirname "$0")

################################################################################

# Main func
#
# *: All arguments passed to script
#
# Code: No
# Echo: No
main() {
  pushd "$script_dir" &> /dev/null || exit 1

    detectOs
    doInstall

  popd &> /dev/null || exit 1
}

# Install app
#
# Code: No
# Echo: No
doInstall() {
  requireRoot

  confirmInstall "mcryptpasswd"

  case $os_dist in
    "$DIST_FEDORA"|"$DIST_CENTOS"|"$DIST_RHEL") requireRPM "python" "cracklib"        ;;
    "$DIST_UBUNTU"|"$DIST_DEBIAN")              requireDEB "python" "libpam-cracklib" ;;
    *) error "Unsupported platform" ; requireFailed=true 
  esac

  if [[ -n "$requireFailed" ]] ; then
    show "" && exit 1
  fi

  action "Copy script to /usr/bib directory" \
         "cp" "SOURCES/mkcryptpasswd" "/usr/bin/mkcryptpasswd"

  action "Add +x flag for script" \
         "chmod" "+x" "/usr/bin/mkcryptpasswd"

  cp SOURCES/mkcryptpasswd.8 .

  action "Pack man page" \
         "gzip" "mkcryptpasswd.8"

  action "Move man page to directory with all man pages" \
         "mv" "mkcryptpasswd.8.gz" "/usr/share/man/man8/"

  congratulate "mcryptpasswd"
}

################################################################################

# Executes installation action
#
# 1: Description (String)
# *: Command
#
# Code: No
# Echo: No
action() {
  local desc="$1"

  shift 1

  if [[ -n "$debug" ]] ; then
    # shellcheck disable=SC2068
    $@
  else
    # shellcheck disable=SC2068
    $@ &> /dev/null
  fi

  if [[ $? -ne 0 ]] ; then
    show "${CL_RED}✖ ${CL_NORM} $desc"
    error "\nError occurred with last action. Installation process was interrupted.\n"
    exit 1
  else
    show "${CL_GREEN}✔ ${CL_NORM} $desc"
  fi
}

# Check required package
#
# 1: Package name (String)
#
# Code: No
# Echo: No
require() {
  local package="$1"

  case $os_dist in
    "$DIST_FEDORA"|"$DIST_CENTOS"|"$DIST_RHEL") requireRPM "$package" ;;
    "$DIST_UBUNTU"|"$DIST_DEBIAN")              requireDEB "$package" ;;
    *)
        error "Unsupported platform"
        requireFailed=true
  esac
}

# Checks for required rpm packages
#
# *: Packages
#
# Code: No
# Echo: No
requireRPM() {
  if [[ -n "$no_deps" ]] ; then
    return
  fi

  local pkg

  for pkg in "$@" ; do
    rpm -q "$pkg" &> /dev/null

    if [[ $? -ne 0 ]] ; then
      error "This app requires package $pkg."
      requireFailed=true
    fi
  done
}

# Checks for required deb packages
#
# *: Packages
#
# Code: No
# Echo: No
requireDEB() {
  if [[ -n "$no_deps" ]] ; then
    return
  fi

  local pkg

  for pkg in "$@" ; do
    dpkg -s "$pkg" &> /dev/null

    if [[ $? -ne 0 ]] ; then
      error "This app requires package $pkg."
      requireFailed=true
    fi
  done
}

# Checks root privileges
#
# Code: No
# Echo: No
requireRoot() {
  if [[ $(id -u) != "0" ]] ; then
    error "Superuser privileges is required"
    exit 1
  fi
}

# Confirms install
#
# 1: App name (String)
#
# Code: Yes
# Echo: No
confirmInstall() {
  if [[ -n "$yes" ]] ; then
    return 0
  fi

  show ""
  show "You really want install latest version of $1? (y/N):" $CYAN

  if ! readAnswer "N" ; then
    return 1
  fi
}

# Congratulates with success install
#
# 1: App name (String)
#
# Code: No
# Echo: No
congratulate() {
  show "\nYay! $1 is successfully installed!\n" $GREEN
}

# Reads user yes/no answer
#
# 1: Default value (String)
#
# Code: Yes
# Echo: No
readAnswer() {
  local defval="$1"
  local answer

  read -re -p "> " answer

  show ""

  answer=$(echo "$answer" | tr "[:lower:]" "[:upper:]")

  [[ -z "$answer" ]] && answer="$defval"

  if [[ ${answer:0:1} == "Y" ]] ; then
    return 0
  else
    return 1
  fi
}

# Collects system info
#
# Code: No
# Echo: No
detectOs() {
  os_name=$(uname -s)

  if [[ "$os_name" == "SunOS" ]] ; then
    os_name=$OS_SOLARIS
  elif [[ "$os_name" == "Darwin" ]]; then
    os_name=$OS_MACOSX
  elif [[ "$os_name" == "Linux" ]] ; then
    os_name="$OS_LINUX"

    if [[ -f /etc/arch-release ]] ; then
      os_dist=$DIST_ARCH
    elif [[ -f /etc/fedora-release ]] ; then
      os_dist=$DIST_FEDORA
    elif [[ -f /etc/gentoo-release ]] ; then
      os_dist=$DIST_GENTOO
    elif [[ -f /etc/redhat-release ]] ; then
      os_dist=$DIST_RHEL
    elif [[ -f /etc/SuSE-release ]] ; then
      os_dist=$DIST_SUSE
    elif [[ -f /etc/lsb-release ]] ; then
      os_dist=$DIST_UBUNTU
    fi
  fi
}

# Shows error message
#
# 1: Message (String)
#
# Code: No
# Echo: No
error() {
  show "$*" $RED 1>&2
}

# Shows warning message
#
# 1: Message (String)
#
# Code: No
# Echo: No
warn() {
  show "$*" $BROWN 1>&2
}

# Shows message
#
# 1: Message (String)
# 2: Color code (Number) [Optional]
#
# Code: No
# Echo: No
show() {
  if [[ -n "$2" ]] ; then
    echo -e "\e[${2}m${1}\e[0m"
  else
    echo -e "$*"
  fi
}

# Prints message about unsupported option
#
# 1: Option name (String)
#
# Code: No
# Echo: No
showOptWarn() {
  error "Unknown option $1"
  exit 1
}

## OPTIONS PARSING 5 ###########################################################

if [[ $# -eq 0 ]] ; then
  main
  exit $?
fi

unset opt optn optm optv optt optk

optv="$*" ; optt=""

while [[ -n "$1" ]] ; do
  if [[ "$1" =~ \  && -n "$optn" ]] ; then
    declare "$optn=$1"

    unset optn && shift && continue
  elif [[ $1 =~ ^-{1}[a-zA-Z0-9]{1,2}+.*$ ]] ; then
    optm=${1:1}

    if [[ \ $SHORT_OPTS\  =~ \ $optm:!?([a-zA-Z0-9_]*) ]] ; then
      opt="${BASH_REMATCH[1]}"
    else
      declare -F showOptWarn &>/dev/null && showOptWarn "-$optm"
      shift && continue
    fi

    if [[ -z "$optn" ]] ; then
      optn=$opt
    else
      # shellcheck disable=SC2015
      [[ -z "$optk" ]] && ( declare -F showOptValWarn &>/dev/null && showOptValWarn "--$optn" ) || declare "$optn=true"
      optn=$opt
    fi

    if [[ ! $SUPPORTED_OPTS\  =~ !?$optn\  ]] ; then
      declare -F showOptWarn &>/dev/null && showOptWarn "-$optm"
      shift && continue
    fi

    if [[ ${BASH_REMATCH[0]:0:1} == "!" ]] ; then
      declare "$optn=true" ; unset optn ; optk=true
    else
      unset optk
    fi

    shift && continue
  elif [[ "$1" =~ ^-{2}[a-zA-Z]{1}[a-zA-Z0-9_-]+.*$ ]] ; then
    opt=${1:2}

    if [[ $opt == *=* ]] ; then
      IFS="=" read -ra opt <<< "$opt"

      optm="${opt[0]}" ; optm=${optm//-/_}

      if [[ ! $SUPPORTED_OPTS\  =~ $optm\  ]] ; then
        declare -F showOptWarn &>/dev/null && showOptWarn "--${opt[0]//_/-}"
        shift && continue
      fi

      # shellcheck disable=SC2015
      [[ -n "${!optm}" && $MERGEABLE_OPTS\  =~ $optm\  ]] && declare "$optm=${!optm} ${opt[*]:1:99}" || declare "$optm=${opt[*]:1:99}"

      unset optm && shift && continue
    else
      # shellcheck disable=SC2178
      opt=${opt//-/_}

      if [[ -z "$optn" ]] ; then
        # shellcheck disable=SC2128
        optn=$opt
      else
        # shellcheck disable=SC2015
        [[ -z "$optk" ]] && ( declare -F showOptValWarn &>/dev/null && showOptValWarn "--$optn" ) || declare "$optn=true"
        # shellcheck disable=SC2128
        optn=$opt
      fi

      if [[ ! $SUPPORTED_OPTS\  =~ !?$optn\  ]] ; then
        declare -F showOptWarn &>/dev/null && showOptWarn "--${optn//_/-}"
        shift && continue
      fi

      if [[ ${BASH_REMATCH[0]:0:1} == "!" ]] ; then
        declare "$optn=true" ; unset optn ; optk=true
      else
        unset optk
      fi

      shift && continue
    fi
  else
    if [[ -n "$optn" ]] ; then
      # shellcheck disable=SC2015
      [[ -n "${!optn}" && $MERGEABLE_OPTS\  =~ $optn\  ]] && declare "$optn=${!optn} $1" || declare "$optn=$1"

      unset optn && shift && continue
    fi
  fi

  optt="$optt $1" ; shift

done

[[ -n "$optn" ]] && declare "$optn=true"

unset opt optn optm optk

# shellcheck disable=SC2015,SC2086
[[ -n "$KEEP_OPTS" ]] && main $optv || main ${optt:1}

################################################################################
