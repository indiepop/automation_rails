#After roadRunner.run() executed,
#execute roadRunner.report() show the Performance report

module RoadRunnerModule

  def report(opts={:label=>'',:width=>0,:msg=>""})
    p "      Wait for moment,the report is collecting......"
    content = if @rep
      @succRates = getSuccessRate @transactions
      <<-DOC
      #{"Performance Reports".center(50, '*')}
      #{opts[:label].ljust(opts[:width])}
      #{Benchmark::Tms::CAPTION}
      #{@rep.format}
      #{'--'*32}
      The Virtual User is #{@users}.
      Total Execute #{@iterations*@users} Action(s).
      Total Cost #{@rep.real} Second(s).
      This Scenario's TPS : #{@tps}.
      The longest action cost #{@longest || 0} seconds.
      #{'Transaction Report'.center(50, '-')}
      #{@transactions.inject("") { |str,k|
      str += "#{k[0].to_s} : count => #{k[1].size} time(s) , cost => #{k[1].inject(0){|c,v|c+=v[:cost].to_f}.to_s[0..3]} sec(s) , success rate => #{@succRates[k[0]]}\n      "
      }.gsub(/\n$/,'')}
      #{'--'*32}
      User defined params as below: 
      #{@global}
      #{"End of Reports".center(50, '*')}
      DOC
    else
      "None Report before RoadRunner run."
    end
    puts content
    self.log.info content
  end

  def save_report(opts={:author=>'Anonymous',:script=>""})

    p "      Saving report to database......"
    opts={:author=>'Anonymous',:script=>""}.merge opts
    if @data_write then
      unless opts[:name] then
        self.log.warn "scenario name may be needed."
        require 'uuidtools' unless defined?UUID
        # scenario || UUID.random_create.to_s is for debug
        opts[:name] = opts[:name] || UUID.random_create.to_s
        self.log.info "scenario is created as #{opts[:name]}"
      end
      # => scenario = Scenario.find_or_create_by_name(opts.merge({:create_at=>Time.now})).shift
      scenario = Scenario.find_or_create_by_name(opts.merge({:create_at=>Time.now}))
      scenario.tps+=@iterations*@users/@rep.real

      # => if opts[:script] is set as <your script>.rb 's path
      # => opts[:script] = __FILE__
      # => then scenario.script will be set.
      if FileTest.exist?(opts[:script]) then
        scenario.script = ""
        IO.foreach(opts[:script]){|x|scenario.script << x}
      end

      @succRates = @succRates || (getSuccessRate @transactions)
      # k is transaction name ,
      # v is reports in every transaction.
      @transactions.each do |k,v|
        transaction  = Transaction.new({:name=>k,:create_at=>Time.now,:success_rate=>@succRates[k]})
        v.each_index do |id|
          transaction.records << Record.new(v[id].merge({:seq=>id,:ts=>v[id][:create_at].to_f-@strat_time.to_f}))
          self.log.debug "v[#{id}] = #{v[id].inspect}"
        end
        scenario.transactions << transaction
      end
      begin
        scenario.save!
        p "      Saved OK!"
      rescue =>e
        self.log.error e
        p e
      end
      self.log.info "records has saved in DB."
    else
      p '      Error:You didn\'t connect any database.'
      self.log.error 'You didn\'t connect any database.'
    end
  end

  def getSuccessRate(transactions)
    result = {}
    transactions.each do |h|
      success,faile = 0,0
      h[1].each do |r|
        r[:stats]==0?success+=1:faile+=1
      end
      result[h[0]]=success.to_f/(success+faile)
    end
    result
  end

  private :getSuccessRate

end