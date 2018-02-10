#!/usr/bin/python
import os.path ,os, string
def echo_ver(mod,root,desc=None,ver_paht="") :
    mod_path = os.path.join(root,mod,ver_paht,"version.txt")
    if desc is None :
        desc = mod
    if not os.path.exists(mod_path) :
        print("%-20s: no found! " %(desc))
        return
    with open(mod_path) as verfile :
        ver = verfile.readline()
        print("%-20s: %s" %(desc,ver))

if __name__ == '__main__':
    echo_ver( "pylon-ng"    , "/data/x/libs")
    echo_ver( "rigger-ng"   , "/data/x/tools")
    echo_ver( "xcc_pub"     , "/data/x/tools")
    echo_ver( "xcc_env"     , "/data/x/etc")
    echo_ver( "xcc_vendor"  , "/data/x/libs",None,"src")
    echo_ver( "xcc_svcs"    , "/data/x/svcs")
    echo_ver( "local_proxy" , "/data/x/svcs")
    echo_ver( "biz_sdk"     , "/data/x/sdks")
    echo_ver( "uac"            , "/data/x/xcc_toc",None,"src")
    echo_ver( "user_gateway"   , "/data/x/projects",None,"src")
    echo_ver( "notify_gateway" , "/data/x/projects",None,"src")
    echo_ver( "coin_spider"    , "/data/x/projects",None,"src")
    echo_ver( "coin"           , "/data/x/projects",None,"src")
    echo_ver( "im" , "/data/x/svcs",None,"src")
