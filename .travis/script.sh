#!/usr/bin/env bash

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
CL_BL_RED="\e[${RED};1m"
CL_BL_GREEN="\e[${GREEN};1m"
CL_BL_BROWN="\e[${BROWN};1m"
CL_BL_BLUE="\e[${BLUE};1m"
CL_BL_MAG="\e[${MAG};1m"
CL_BL_CYAN="\e[${CYAN};1m"
CL_BL_GREY="\e[${GREY};1m"
CL_UL_RED="\e[${RED};4m"
CL_UL_GREEN="\e[${GREEN};4m"
CL_UL_BROWN="\e[${BROWN};4m"
CL_UL_BLUE="\e[${BLUE};4m"
CL_UL_MAG="\e[${MAG};4m"
CL_UL_CYAN="\e[${CYAN};4m"
CL_UL_GREY="\e[${GREY};4m"
CL_BG_RED="\e[${RED};7m"
CL_BG_GREEN="\e[${GREEN};7m"
CL_BG_BROWN="\e[${BROWN};7m"
CL_BG_BLUE="\e[${BLUE};7m"
CL_BG_MAG="\e[${MAG};7m"
CL_BG_CYAN="\e[${CYAN};7m"
CL_BG_GREY="\e[${GREY};7m"

########################################################################################

# Default password (String)
PASSWORD="test1234ABCD"

# Default salt (String)
SALT="TeSt"

# Default salt length (Number)
SALT_LENGTH=6

# Path to 7zcat script (String)
MKCP="SOURCES/mkcryptpasswd"

# Has errors
global_errors=""

########################################################################################

# Main func
#
# 1: All arguments passed to script 
#
# Code: No
# Echo: No
main() {
  showm "Checking hashes length:       "

  testHashLen

  showm "Checking hashes salt:         "

  testHashSalt

  showm "Checking hashes salt length:  "

  testHashSaltLength

  showm "Checking hashes salt min/max: "

  testHashSaltMinMax

  showm "Checking hashing result:      "

  testHashResult

  if [[ $global_errors ]] ; then
    exit 1
  fi

  exit 0
}

# Check default result length
#
# Code: No
# Echo: No
testHashLen() {
  local hash1 hash5 hash6 has_errors

  hash1=$(echo "$PASSWORD" | . "$MKCP" -1 -S)
  hash5=$(echo "$PASSWORD" | . "$MKCP" -5 -S)
  hash6=$(echo "$PASSWORD" | . "$MKCP" -6 -S)

  [[ ${#hash1} -ne 34 ]] && showm "." $RED && has_errors=true || showm "." $GREEN
  [[ ${#hash5} -ne 55 ]] && showm "." $RED && has_errors=true || showm "." $GREEN
  [[ ${#hash6} -ne 98 ]] && showm "." $RED && has_errors=true || showm "." $GREEN

  if [[ $has_errors ]] ; then
    global_errors=true
    show " ✘ " $RED
    return
  fi

  show " ✔ " $GREEN
}

# Check salt usage
#
# Code: No
# Echo: No
testHashSalt() {
  local hash1 hash5 hash6 hash1S hash5S hash6S has_errors

  hash1=$(echo "$PASSWORD" | . "$MKCP" -1 -S -sa "$SALT")
  hash5=$(echo "$PASSWORD" | . "$MKCP" -5 -S -sa "$SALT")
  hash6=$(echo "$PASSWORD" | . "$MKCP" -6 -S -sa "$SALT")
  
  hash1S=$(extractSalt "$hash1")
  hash5S=$(extractSalt "$hash5")
  hash6S=$(extractSalt "$hash6")

  [[ "$SALT" != "$hash1S" ]] && showm "." $RED && has_errors=true || showm "." $GREEN
  [[ "$SALT" != "$hash5S" ]] && showm "." $RED && has_errors=true || showm "." $GREEN
  [[ "$SALT" != "$hash6S" ]] && showm "." $RED && has_errors=true || showm "." $GREEN

  if [[ $has_errors ]] ; then
    global_errors=true
    show " ✘ " $RED
    return
  fi

  show " ✔ " $GREEN
}

# Check generated salt length
#
# Code: No
# Echo: No
testHashSaltLength() {
  local hash1 hash5 hash6 hash1S hash5S hash6S has_errors

  hash1=$(echo "$PASSWORD" | . "$MKCP" -1 -S -sl $SALT_LENGTH)
  hash5=$(echo "$PASSWORD" | . "$MKCP" -5 -S -sl $SALT_LENGTH)
  hash6=$(echo "$PASSWORD" | . "$MKCP" -6 -S -sl $SALT_LENGTH)

  hash1S=$(extractSalt "$hash1")
  hash5S=$(extractSalt "$hash5")
  hash6S=$(extractSalt "$hash6")

  [[ ${#hash1S} -ne $SALT_LENGTH ]] && showm "." $RED && has_errors=true || showm "." $GREEN
  [[ ${#hash5S} -ne $SALT_LENGTH ]] && showm "." $RED && has_errors=true || showm "." $GREEN
  [[ ${#hash6S} -ne $SALT_LENGTH ]] && showm "." $RED && has_errors=true || showm "." $GREEN

  if [[ $has_errors ]] ; then
    global_errors=true
    show " ✘ " $RED
    return
  fi

  show " ✔ " $GREEN
}

# Check salt max/min values
#
# Code: No
# Echo: No
testHashSaltMinMax() {
  local hashS hashB1 hashB5 hashSS hashB1S hashB5S has_errors

  hashS=$(echo "$PASSWORD" | . "$MKCP" -5 -S -sl 2)
  hashB1=$(echo "$PASSWORD" | . "$MKCP" -1 -S -sl 60)
  hashB5=$(echo "$PASSWORD" | . "$MKCP" -5 -S -sl 60)

  hashSS=$(extractSalt "$hashS")
  hashB1S=$(extractSalt "$hashB1")
  hashB5S=$(extractSalt "$hashB5")

  [[ ${#hashSS} -ne 4   ]] && showm "." $RED && has_errors=true || showm "." $GREEN
  [[ ${#hashB1S} -ne 8  ]] && showm "." $RED && has_errors=true || showm "." $GREEN
  [[ ${#hashB5S} -ne 16 ]] && showm "." $RED && has_errors=true || showm "." $GREEN

  if [[ $has_errors ]] ; then
    global_errors=true
    show " ✘ " $RED
    return
  fi

  show " ✔ " $GREEN
}

# Check hashing result
#
# Code: No
# Echo: No
testHashResult() {
  local hash1 hash5 hash6 hash1S hash5S hash6S hash1R hash5R hash6R

  hash1=$(echo "$PASSWORD" | . "$MKCP" -1 -S)
  hash5=$(echo "$PASSWORD" | . "$MKCP" -5 -S)
  hash6=$(echo "$PASSWORD" | . "$MKCP" -6 -S)

  hash1S=$(extractSalt "$hash1")
  hash5S=$(extractSalt "$hash5")
  hash6S=$(extractSalt "$hash6")

  hash1R=$(echo "$PASSWORD" | . "$MKCP" -1 -S -sa "$hash1S")
  hash5R=$(echo "$PASSWORD" | . "$MKCP" -5 -S -sa "$hash5S")
  hash6R=$(echo "$PASSWORD" | . "$MKCP" -6 -S -sa "$hash6S")

  [[ "$hash1" != "$hash1R" ]] && showm "." $RED && has_errors=true || showm "." $GREEN
  [[ "$hash5" != "$hash5R" ]] && showm "." $RED && has_errors=true || showm "." $GREEN
  [[ "$hash6" != "$hash6R" ]] && showm "." $RED && has_errors=true || showm "." $GREEN

  if [[ $has_errors ]] ; then
    global_errors=true
    show " ✘ " $RED
    return
  fi

  show " ✔ " $GREEN
}

# Extract salt from hashed password
#
# 1: Hashed password (String)
#
# Code: No
# Echo: Salt (String)
extractSalt() {
  echo "$1" | cut -f3 -d"$"
}

# Show message
#
# 1: Message (String)
# 2: Message color (Number) [Optional]
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

# Show message without newline symbol
#
# 1: Message (String)
# 2: Color (Number) [Optional]
#
# Code: No
# Echo: No
showm() {
  if [[ -n "$2" ]] ; then
    echo -e -n "\e[${2}m${1}\e[0m"
  else
    echo -e -n "$*"
  fi
}

########################################################################################

main "$@"
