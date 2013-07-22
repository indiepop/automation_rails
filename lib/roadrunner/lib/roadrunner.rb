# Author : zheng.cuizh@gmail.com
# Change :josh.yangzhuo@gmail.com
# RoadRunner named lik LoadRunner which is a industry performance test tool of HP.
# I'm happy to user LR and Ruby,
# so i coded the RoadRunner.
# Using RR,you'll find somethings similar to LR.

$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'benchmark'
require 'logger'
require 'pp'
require 'yaml'
require 'active_record'

Dir[File.join(File.dirname(__FILE__),"*.rb")].select{|x|not ( x =~ /.*roadrunner\.rb/)}.each { |x| require x  }

class RoadRunner

  include RoadRunnerModule
  attr :iterations,true
  attr :users,true
  attr :global,true
  attr :iterationId
  attr :record
  attr :userId
  attr :mode,true
  attr :log,true
  attr :tps
  alias_method :g,:global
  alias_method :g=,:global=
  attr :running_report, true

  def initialize(opts={})
    # => DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN
    p   File.dirname(__FILE__)

    opts = {:out=>  File.join(File.dirname(__FILE__),'..','..','..','log',"stdout.log"),:frequency=>'daily',:size=>1048576,:level=>Logger::DEBUG}.merge opts      #日志参数
    @users,@iterations,@longest,@userId,@iterationId=1,1,0,0,0   #用户数，迭代次数
    @initBlk,@actBlk,@endBlk=proc{},proc{},proc{}      #定义初始化，动作，结束模块
    @global,@transactions={},{}
    @log = Logger.new(opts[:out],opts[:frequency],opts[:size])
    @log.level=opts[:level]
    @log.info("#{'-'*20} #{$0} RoadRunner log #{'-'*20}")
     # => mode : sequence<default>,thread|t,process|p                                                                                                                                                  # => mode : sequence<default>,thread|t,process|p
    @mode='sequence'
    @running_report=''
    @transaction_blk={}

      db_info = YAML.load_file(File.join(File.dirname(__FILE__),'..','..','..','config',"database.yml"))

      begin
        ActiveRecord::Base.establish_connection(
            db_info['development']              #load the rails db
        )
        self.log.info "connect db ok."
      rescue => ex
        self.log.error "adapter:#{db_info['development']['adapter']}.connect db faile."
      end

    default_report_table = %w"scenarios transactions records"

      unless @data_write = default_report_table.inject(true){|r,t| r = r && ActiveRecord::Base.connection.tables.include?(t)} then
        self.log.warn "table rreports doesn't defined and will be created."
        Dbhelper::migrate default_report_table
        if @data_write = default_report_table.inject(true){|r,t| r = r && ActiveRecord::Base.connection.tables.include?(t)} then
          self.log.info "create table #{default_report_table.inspect} successful."
        else
          self.log.error "create table #{default_report_table.inspect} fail."
        end
      end
      require 'model' unless defined? Scenario
      self.log.debug 'model Rreport is reqruired.'
    end


  def transaction(name,&blk)
    @transactions[name] || @transactions[name] = []
    status = "AUTO"
    # => Status is the last expression in the action block
    rcost = Benchmark::realtime{status = yield} if block_given?
    # => status's value is:
    # => 0=>success
    # => -1=>faile
    case status
    when false,'false','-1',-1 then status = -1
    else status = 0
    end
    # {:stats=>status,:cost=>rcost,:create_at=>Time.now} is one record
    @transactions[name] << {:stats=>status,:cost=>rcost,:create_at=>Time.now.to_s}
    # => the below sentence cost a lot of system resource
    # => if you run for production result,keep it annotated!!!
    # self.log.debug "#{name} => "+@transactions[name].inspect
    rcost
  end

  def register_transactions(name,&blk)
    @transaction_blk[name]=blk
  end


  def method_missing(name,*args,&blk)
    # self.transaction(name.to_s,&blk)
    register_transactions(name,&blk)
  end

end
