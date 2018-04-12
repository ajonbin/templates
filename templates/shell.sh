#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e 

# Print out the command before execute
#set -x

#Collect path and file info
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__parent="$(cd "$(dirname "${__dir}")" && pwd)"

declare -r PROGRAME=$(basename "$0")

usage(){
    if [ "$*" != "" ] ; then
        echo "Error: $*"
        echo ""
    fi

    cat  << EOF
Usage: "$PROGRAME" [options] param1 param2
<Description Here>

Options:
-h, --help          Display this usage and exit
EOF
    exit 1
}

work() {
    declare arg1="$1" arg2="$2"
    printf "Argument1: %s, Argument2 : %s\n" "$arg1" "$arg2"

}

main() {
    local param1=""
    local param2=""

    while [ "$#" -gt 0 ] ; do
        case "$1" in
        -h|--help)
            usage
            ;;
        -*)
            usage "Unknown option '$1'"
            ;;
        *)
            if [ -z "$param1" ] ; then
                param1="$1"
            elif [ -z "$param2" ]; then
                param2="$1"
            else
                usage "Too many arguments"
            fi
            ;;
        esac
        shift
    done

    if [ -z "$param1" ] || [ -z "$param2" ]; then
        usage "No param set"
    fi

    work "$param1" "$param2"

}

main $@
