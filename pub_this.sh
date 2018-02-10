TAG=`cat ./version.txt`
echo $TAG ;
cd $HOME/devspace/%{PRJ_NAME} ;
./rocket_pub.sh  --prj %{PRJ_NAME}  --tag $TAG --host $*
