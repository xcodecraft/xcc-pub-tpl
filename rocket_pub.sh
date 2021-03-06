#!/bin/bash
CUR_DIR=$(cd "$(dirname "$0")"; pwd)
cd $CUR_DIR

function usage() {
    echo "usage: $0  --plan  plan_name   --tag project_tag   --env  env_name [ --dver  deploy_ver] [--local local_path]"
    }

while [ "$1" != "" ]; do
    case $1 in
        --plan )           shift
                           plan_name=$1
                           ;;
        --tag )            shift
                           project_tag=$1
                           ;;

        --env )            shift
                           env_name=$1
                           host_list=$1
                           ;;
        --local)           shift
                           local_path="local_path=$1"
                           ;;

        --dver )           shift
                           deploy_ver="-$1"
                           ;;
        -h | --help )      usage
                           exit
                           ;;
        * )                usage
                           exit 1
    esac
    shift
done

host_list=${host_list:-'develop'}

if [ "$plan_name" = "" ] ; then
  usage
  exit
fi

if [ "$env_name" = "" ] ; then
    env_name=$host_list
fi

if [  "$project_tag" = "" ]; then
    usage
    exit
fi


echo $(tput setaf 2) "---> 开始部署项目：" $(tput setaf 5) $project_name
echo $(tput setaf 2) "---> 版本号：" $(tput setaf 5) $project_tag
echo $(tput setaf 2) "---> 机器列表：" $(tput setaf 5) $host_list


ansible-playbook -i plans/${plan_name}/hosts src/pub.yml  --extra-var @plans/${plan_name}/vars.yml --extra-var "user=$USER  env=${env_name} host=${host_list} project_version=${project_tag}   deploy_ver=${deploy_ver}"  -k --ask-become-pass
