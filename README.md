>## Welcome to Automation Rails

Rails is a web-application framework that includes everything needed to create
database-backed web applications according to the Model-View-Control pattern.

Automation-Rails integrated rails + mysql + selenium-webdriver + cucumber + roadrunner + SNMPSIM.
In Automation-Rails, you can do both web-automation testing , performance testing and SNMP simulation .


>### Getting Started


1. git clone https://github.com/indiepop/automation_rails.git
2. sudo apt-get install bundler mysql-server rake
3. bundle update/bundle install 
4. edit your own config/database.yml
5. rake db:migrate
6. rake db:seed
7. rails server

PS: To use SNMP function , you should also install 'snmpsim':

1. python -V (install python)
2. sudo apt-get install python-setuptools
3. sudo easy_install snmpsim


>### Introduction

>######The framework has three main features:

> Web-automation-testing: case management, auto-execution, report management, BDD.
>
> Performance testing: using an open-source Roadrunner module to do load test, which is integrated, and has great performance report.
>
> SNMP Simulating: with snmp simulator , users can simulate a new device with snmp.
>
>### Cucumber Summary
![Main](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/cucumber.jpg)
>
>This is the construction of Cucumber.

>### Screenshot
![Main](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/main_page.jpg)
>This is the main page.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/report.jpg)
>Cucumber Report.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/running_by_tag.jpg)
>Running by cucumber tags.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/machine_management.jpg)
>Machine management if you need to run remotely.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/remote_machine_running.jpg)
>Remote machine running settings.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/roadrunner_execution.jpg)
>RoadRunner scenario settings.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/roadrunner_report.jpg)
>RoadRunner Report.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/snmp.jpg)
>SNMP Demo(To simulate a device or create a record by snmp)





------------------------------------------------------------------------------------------------


>## 欢迎来到 Automation Rails

Rails 是一个web框架，相当牛逼。

我们的 Automation-Rails 集成了 rails + mysql + selenium-webdriver + cucumber + roadrunner +snmpsim 这些组件。
通过此框架，你可以轻松进行web自动化,性能测试和SNMP设备模拟。



>### 开始吧

1. install mysql server （安装好mysql）
2. git clone https://github.com/indiepop/automation_rails.git   （克隆到本地）
3. bundle install                            （安装依赖包）
4. edit your own config/database.yml        （修改数据库用户名密码）
5. rake db:migrate                            （数据迁移）
6. rake db:seed                                （加载原始数据）
7. rails server                              （启动）

PS: To use SNMP function , you should also install 'snmpsim':

1. python -V (install python)
2. sudo apt-get install python-setuptools
3. sudo easy_install snmpsim



>### 介绍

>###### 这个框架有三个特性:

> 页面自动化测试: 用例管理, 自动执行, 报告管理, BDD（用户行为驱动）.在自动执行方面尤为出色，主要体现在单用例执行，标签执行，多机器执行等。。
>
> 性能测试： 利用开源框架Roadrunner, 本框架对其进行重构。免费，开源，可操作性强，报告详尽。
>
> SNMP 模拟： 现在这个功能牛逼了，用户可以通过导入csv文件或者snmprec文件的方式模拟出一台基于snmp协议的设备，当然用户也可以通过此工具录制任意一台具有snmp协议的物理网络设备。
>

