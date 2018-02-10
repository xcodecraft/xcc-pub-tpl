#!/bin/bash
CUR_DIR=$(cd "$(dirname "$0")"; pwd)
cd $CUR_DIR

function usage() {
    echo "usage: $0 --prj project_name [--plan plan_name] --command ( conf|start|stop|clean)   --host host_list(dev|testing|production)  "
    }

while [ "$1" != "" ]; do
    case $1 in
        --prj )           shift
                           project_name=$1
                           ;;

        --plan )           shift
                           plan_name=$1
                           ;;
        --command )        shift
                           command=$1
                           ;;
        --host )           shift
                           host_list=${1:-'dev'}
                           ;;

        --env )            shift
                           env_name=$1
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

if [ "$plan_name" = "" ] ; then
    plan_name=$project_name
fi

if [ "$env_name" = "" ] ; then
    env_name=$host_list
fi
if [  "$command" = "" ]; then
    usage
    exit
fi


ansible -i projects/${project_name}/hosts $host_list -m shell -a "/data/x/tools/rigger-ng/rg ${command} chdir=/data/x/projects/${project_name}" -b --become-user=root --become-method=sudo --ask-become-pass -k  -vvvv
