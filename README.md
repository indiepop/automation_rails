>## Welcome to Automation Rails

Rails is a web-application framework that includes everything needed to create
database-backed web applications according to the Model-View-Control pattern.

Automation-Rails integrated rails + mysql + selenium-webdriver + cucumber + roadrunner.
In Automation-Rails, you can do both web-automation testing and performance testing.


>### Getting Started

1. install mysql server
2. git clone https://github.com/indiepop/automation_rails.git
3. bundle install
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
>### Screenshot

![Main](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/main_page.jpg)
>This is the main page.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/report.jpg)
>Cucumber Report.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/running_by_tag.jpg)
>Running by cucumber tags.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/machine_management.jpg)
>Machine management if you need to run remotely.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/mutiple_machine_running.jpg)
>Multiple machine running settings.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/roadrunner_execution.jpg)
>RoadRunner scenario settings.
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/roadrunner_report.jpg)
>RoadRunner Report.
>SNMP Demo(To simulate a device or create a record by snmp).
![Josh](https://raw.github.com/indiepop/automation_rails/master/app/assets/images/snmp.jpg)
>SNMP Report.


>### Debugging Rails

Sometimes your application goes wrong. Fortunately there are a lot of tools that
will help you debug it and get it back on the rails.

First area to check is the application log files. Have "tail -f" commands
running on the server.log and development.log. Rails will automatically display
debugging and runtime information to these files. Debugging info will also be
shown in the browser on requests from 127.0.0.1.

You can also log your own messages directly into the log file from your code
using the Ruby logger class from inside your controllers. Example:

  class WeblogController < ActionController::Base
    def destroy
      @weblog = Weblog.find(params[:id])
      @weblog.destroy
      logger.info("#{Time.now} Destroyed Weblog ID ##{@weblog.id}!")
    end
  end

The result will be a message in your log file along the lines of:

  Mon Oct 08 14:22:29 +1000 2007 Destroyed Weblog ID #1!

More information on how to use the logger is at http://www.ruby-doc.org/core/

Also, Ruby documentation can be found at http://www.ruby-lang.org/. There are
several books available online as well:

* Programming Ruby: http://www.ruby-doc.org/docs/ProgrammingRuby/ (Pickaxe)
* Learn to Program: http://pine.fm/LearnToProgram/ (a beginners guide)

These two books will bring you up to speed on the Ruby language and also on
programming in general.


>### Debugger

Debugger support is available through the debugger command when you start your
Mongrel or WEBrick server with --debugger. This means that you can break out of
execution at any point in the code, investigate and change the model, and then,
resume execution! You need to install ruby-debug to run the server in debugging
mode. With gems, use <tt>sudo gem install ruby-debug</tt>. Example:

  class WeblogController < ActionController::Base
    def index
      @posts = Post.all
      debugger
    end
  end

So the controller will accept the action, run the first line, then present you
with a IRB prompt in the server window. Here you can do things like:

  >> @posts.inspect
  => "[#<Post:0x14a6be8
          @attributes={"title"=>nil, "body"=>nil, "id"=>"1"}>,
       #<Post:0x14a6620
          @attributes={"title"=>"Rails", "body"=>"Only ten..", "id"=>"2"}>]"
  >> @posts.first.title = "hello from a debugger"
  => "hello from a debugger"

...and even better, you can examine how your runtime objects actually work:

  >> f = @posts.first
  => #<Post:0x13630c4 @attributes={"title"=>nil, "body"=>nil, "id"=>"1"}>
  >> f.
  Display all 152 possibilities? (y or n)

Finally, when you're ready to resume execution, you can enter "cont".



------------------------------------------------------------------------------------------------


>## 欢迎来到 Automation Rails

Rails 是一个web框架，相当牛逼。

我们的 Automation-Rails 集成了 rails + mysql + selenium-webdriver + cucumber + roadrunner 这些组件。
通过此框架，你可以轻松进行web自动化和性能测试。



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
> SNMP 模拟： 现在这个功能牛逼了，用户可以通过导入csv文件或者snmprec文件的方式模拟出一台基于snmp协议到机器，当然用户也可以通过此工具录制任意一台具有snmp协议的物理机器。
>

