#Here is LR init function
#This part considering to abandon
module RoadRunnerModule
  def init(&blk)

    if block_given?
      @initBlk=blk
      register_transactions('init',&blk)
    else
      raise ArgumentError, "no block"
    end

  end
end