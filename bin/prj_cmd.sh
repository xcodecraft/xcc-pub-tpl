#!/usr/bin/python
import os.path ,os, string,getopt,sys
from subprocess import *
def get_project_path(project) :
    path    = None
    trypaths = [
                "/data/x/tools/",
                "/data/x/etc",
                "/data/x/libs",
                "/data/x/svcs",
                "/data/x/sdks",
                "/data/x/projects",
                ]

    for tpath in trypaths :
        trypath = os.path.join(tpath,project)
        if os.path.exists(trypath)  :
            path =  trypath
            break
    return path
def syscall(cmd) :
    p    = Popen(cmd, shell=True,bufsize=1024, stdout=PIPE, close_fds=True)
    p.wait()
    for line in p.stdout.readlines() :
        print(line)

if __name__ == '__main__':
    try:
        opts, args = getopt.getopt(sys.argv[1:], "p:c:")
    except getopt.GetoptError as err:
        print(str(err))
        exit(-1)
    project = None
    command = None
    for o, a in opts:
        if o == "-p":
            project = a
        if o == "-c":
            command = a
    if project is None or command is None :
        print("bad args")
        exit(-1)
    path = get_project_path(project)
    if command == "ver" :
        cmd = "find %s/ -name version.txt | xargs cat " %(path)
        print(cmd)
        syscall(cmd)
    if command == "restart" :
        cmd  = "cd %s ; /data/x/tools/rigger-ng/rg reconf,restart" %(path)
        syscall(cmd)
    if command == "uninstall" :
        cmd  = "cd %s ; /data/x/tools/rigger-ng/rg stop,clean" %(path)
        syscall(cmd)
