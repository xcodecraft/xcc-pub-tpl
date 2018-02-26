# 发布工具

示例:通过xcc-pub-tpl 生成hero-pub　项目
``` shell
    git clone git@github.com:xcodecraft/xcc-pub-tpl.git
    rg tpl -t ~/devspace/xcc-pub-tpl  -o ~/devspace/xcc-pub

```
# 用法



## . 在plans 下建立发布计划
    ```
    cd plans
    mkdir rigger-ng
    ```

###   vars.yaml

   ``` yaml
   project_name: "rigger-ng"
   deploy_to: "/data/htdocs"
   ```
   可选项
   ``` yaml
   before_rg : "stop"
   after_rg  : "start -e {{env}} -s admin,api"
   after_cmd : "/data/x/projects/rigger-ng/setup.sh"
   ```
   * before_rg  在实装前执行的rg 指令
   * after_rg   在安装后执行的rg 指令
   * after_cmd  在安装后执行的shell 脚本

## 建立发布目标环境
### . 在hosts新建或复用hosts 

    hosts: 内含以环境为组的主机列表
    ``` ini
    [dev]
        ip1
        ip2
        ...

    [test]
        ip1
        ip2
        ...
    ```
dev,test为环境名称   
###　为plan应用hosts

在 ./_rg/_run.yaml 添加 link
``` yaml
_sys:
    -  !R.system
        _name : "init"
        _res  :
            - !R.link
                dst : "${PRJ_ROOT}/plans/rigger-ng/hosts"
                src : "${PRJ_ROOT}/hosts/all.hosts"
```

## 发布

 ``` shell
 rocket_pub.sh --plan rigger-ng --tag 0.0.1 --env dev

 ```

 通过extra-var 传递每次发布可能需要变化的参数。传递与vars.yml 同名的变量，会覆盖vars.yml 里面的变量。
