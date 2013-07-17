#Here is LR End function
#This part considering to abandon
module RoadRunnerModule
  def ended(&blk)

    if block_given?
      @endBlk=blk
      register_transactions('end',&blk)
    else
      raise ArgumentError, "no block"
    end

  end
end