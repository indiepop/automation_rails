#After roadRunner.run() executed,
#execute roadRunner.report() show the Performance report

module RoadRunnerModule
  def run
    @strat_time = Time.now
    @initBlk.call
    @thread_pool = {}
    @counter = 0

    @log.debug "Mode => #{@mode}"
    
    # >> Benchmark.bm {|x|x.report{(1..10).to_a.max}}
    #       user     system      total        real
    #   0.000000   0.000000   0.000000 (  0.000034)
    # => true
    # >> Benchmark.bm {|x|x.report{(1..100).to_a.max}}
    #       user     system      total        real
    #   0.000000   0.000000   0.000000 (  0.000214)
    # => true
    # >> Benchmark.bm {|x|x.report{(1..1000).to_a.max}}
    #       user     system      total        real
    #   0.000000   0.000000   0.000000 (  0.002074)
    # => true
    # >> Benchmark.bm {|x|x.report{(1..1000000).to_a.max}}
    #       user     system      total        real
    #   1.030000   0.670000   1.700000 (  1.766415)
    # => true
    
    iterationBlk = case @mode
    when /thread/,/t/ then
      proc {      
        @users.times do |userId|
          @thread_pool[Thread.start(){
            @iterations.times do |iterationId|
              
              rcost = []
              @transaction_blk.each_pair{|k,v|
                rcost << self.transaction(k,&v)
              }
              
              # rcost = self.transaction('Action',&@actBlk)
              # @log.debug "IterationID is #{self.iterationId};UserID is #{self.userId};This Action Cost #{rcost} seconds"
              @longest = (@longest<rcost.max) ? rcost.max : @longest
              @thread_pool[Thread.current][:iterationId] = iterationId
            end
            @counter += 1
          }]={:userId=>userId}
        end
       # @thread_pool.keys.each{|t|t.join}
        while @counter != @users do
          Thread.pass
        end
      }
    when /process/,/p/ then
      proc {
        ppid=Process.pid
        # @log.info("Main Process pid => #{ppid}")
        
        pids=[]
        @users.times { |userId|
          pids << Process.fork { 
            rcost = {}
            @userId=userId
            @iterations.times do |iterationId|
              @iterationId=iterationId
              
              @transaction_blk.each_pair{|k,v|
                rcost[k]=[] unless rcost[k]
                rcost[k] << self.transaction(k,&v)
                # self.log.info("rcost => #{rcost.inspect}")
              }
              
            end
            
            # >> r
            # => {:y=>[2, 1, 5, 9], :x=>[1, 2, 3, 4]}
            # >> r.map{|x|{x[0]=>x[1].max}}
            # => [{:y=>9}, {:x=>4}]
            m=0
            rcost.map{|x|{x[0]=>x[1].max}}.each{|h|
             if(h.values[0]>m) 
               @longest=h
             end
            }
            
            succRates = getSuccessRate @transactions
            
            preport=
<<-DOC
<PID:#{Process.pid}> <UserId:#{@userId}>
#{'Process Transaction Report'.center(50, '-')}
#{@transactions.inject("") { |str,k|
  str += "#{k[0].to_s} : count => #{k[1].size} time(s) , cost => #{k[1].inject(0){|c,v|c+=v[:cost].to_f}.to_s[0..3]} sec(s) , success rate => #{succRates[k[0]]}#{$/}"
}.gsub(/\n$/,'')}
#{'--'*32}
DOC
            self.log.info(preport)
            puts(preport)
            
            # @log.info @longest.inspect
            @log.info("<PID:#{Process.pid}> going down.Longest job(#{@longest.keys[0]}) cost #{@longest.values[0]}")
            p ("<PID:#{Process.pid}> going down.Longest job(#{@longest.keys[0]}) cost #{@longest.values[0]}")
            
            Process.kill("HUP", ppid)
          }
        }
        
        switch=true
        c=0
        Signal.trap("HUP", proc { @log.info("One User(Process) done."); (switch = false;p "Main process<#{Process.pid}> going down.") if ((c+=1) == @users) })
        
        @log.info "Waiting Processes => #{pids.inspect}"
        
        p "Processes<#{pids.inspect}> working."
        while switch
          STDOUT.puts '.'
          sleep 5
        end
        p $/
        
        Process.waitall
        @log.info "Processes down."
      }
    else
      proc {
        @iterations.times do |iterationId|
          @iterationId=iterationId
          @users.times do |userId|
            @userId=userId
            
            rcost = []
            @transaction_blk.each_pair{|k,v|
              rcost << self.transaction(k,&v)
            }
            
            # rcost = self.transaction('Action',&@actBlk)
            
            # => the below sentence cost a lot of system resource
            # => if you run for production result,keep it annotated!!!
#            self.log.debug "IterationID is #{self.iterationId};UserID is #{self.userId};This Action Cost #{rcost} seconds"
            @longest = (@longest<rcost.max) ? rcost.max : @longest
          end
        end
      }
    end

    p '      '+"RoadRunner".center(50, '*')
    p '      *'+"---Run , on your way.".rjust(48, ' ')+'*'
    p '      '+'*'*50
    p
    p "      Running......"
    @rep = Benchmark::measure(&iterationBlk)
    p "      Ending......"
    @endBlk.call

    @tps = @iterations*@users/@rep.real
  end
end