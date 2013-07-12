# 莱布尼兹公式计算圆周率
#rrpi.global[:deep]代表计算的深度
#深度越深，计算越精确，当然也越耗时



$:.unshift File.expand_path( File.join(File.dirname(__FILE__),'..','lib'))
require 'roadrunner'

#rrpi=RoadRunner.new(:out=>"#{File.join(File.dirname(__FILE__),'roadrunner_stdout.log')}")


rrpi=RoadRunner.new



rrpi.init do
  rrpi.global[:pi],rrpi.global[:deep]=0,1000

  # users决定同时有多少并发用户一起执行action
  # iterations决定每个用户执行多少次
  rrpi.users,rrpi.iterations=10,10
end


rrpi.action do

  # 新增加了iterationId和userId两个接口方法，
  # 可以通过iterationId获得当前action执行到第一次
  # 可以通过userId获得当前action执行用户的id
  #  puts rrpi.iterationId
  #  puts rrpi.userId
  1.upto(rrpi.global[:deep]){|x|rrpi.global[:pi]+=((-1)**(x+1)*1.0/(x*2-1))}
end

rrpi.ended do
  rrpi.global[:pi]*=4
  #rrpi.global={}
end



rrpi.run
=begin

rrpi.report
rrpi.save_report("pi_conputiong_perf_01")

=end