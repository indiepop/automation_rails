$:.unshift File.expand_path( File.join(File.dirname(__FILE__),'..','lib'))

require 'roadrunner'
require 'httparty'


baidu = RoadRunner.new
baidu.users, baidu.iterations,baidu.mode= 1,1,'p'


  baidu.query  do
    resp = HTTParty.get('http://www.baidu.com/')
  end
  baidu.sina do
    HTTParty.get('http://www.sina.com.cn')
  end

baidu.run
baidu.report
