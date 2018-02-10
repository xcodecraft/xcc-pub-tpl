#!/bin/bash
CUR_DIR=$(cd "$(dirname "$0")"; pwd)
cd $CUR_DIR

function usage() {
    echo "usage: $0  --command cmd   --host host_list(dev|demo|online) "
    }

while [ "$1" != "" ]; do
    case $1 in
        --command )            shift
                           command=$1
                           ;;


        --host )           shift
                           host_list=${1:-'dev'}
                           ;;
        -h | --help )      usage
                           exit
                           ;;
        * )                usage
                           exit 1
    esac
    shift
done

host_list=${host_list:-'dev'}

if [  "$command" = "" ]; then
    usage
    exit
fi


ansible -i  conf/all.hosts $host_list -m shell -a "${command} chdir=/data/x/" -b --become-user=root --become-method=sudo --ask-become-pass -k
