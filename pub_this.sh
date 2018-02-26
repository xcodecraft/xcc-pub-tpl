TAG=`cat ./version.txt`
echo $TAG ;
cd $HOME/devspace/%{PRJ_NAME} ;
./rocket_pub.sh  --plan %{PRJ_NAME}  --tag $TAG --env $*
