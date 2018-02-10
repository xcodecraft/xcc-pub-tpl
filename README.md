# 发布工具

示例:通过xcc-pub-tpl 生成hero-pub　项目
``` shell
    git clone git@github.com:xcodecraft/xcc-pub-tpl.git
    rg tpl -t ~/devspace/xcc-pub-tpl  -o ~/devspace/hero-pub

```

# 用法



## . 在projects 目录下以项目名字新建目录:
    ```
    cd projects
    mkdir xcc_sdks
    ```

## . 新建文件 hosts 和 vars.yml

    hosts: 内含要发布的主机列表
    ```
    [develop]
        ip1
        ip2
        ...

    [testing]
        ip1
        ip2
        ...
    ```
    可以管理多组不同环境的主机列表。 develop 和tesing 为每组的主机名

##    vars.yaml

   ```
   project_name: "xcc_sdks"
   deploy_to: "/data/htdocs"
   ```
   可选项
   ```
   before_rg : "stop"
   after_rg  : "start -e {{host}} -s admin,api"
   after_cmd : "/data/x/projects/<you-project>/setup.sh"
   ```
   * before_rg  在实装前执行的rg 指令
   * after_rg   在安装后执行的rg 指令
   * after_cmd  在安装后执行的shell 脚本

##. 使用方法

 ```
 rocket_pub.sh --prj xcc_sdk --tag 0.0.1 --host develop

alias rocket_pub.sh=rocket
 ```

    通过extra-var 传递每次发布可能需要变化的参数。传递与vars.yml 同名的变量，会覆盖vars.yml 里面的变量。

