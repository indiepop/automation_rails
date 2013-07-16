$:.unshift File.expand_path( File.join(File.dirname(__FILE__),'..','lib'))

require 'roadrunner'
require 'httparty'


baidu = RoadRunner.new

baidu.init do
  baidu.users, baidu.iterations= 2,2
end

baidu.action do
  baidu.query do
    resp = HTTParty.get('http://www.baidu.com/')
  end
end

baidu.run
baidu.report
