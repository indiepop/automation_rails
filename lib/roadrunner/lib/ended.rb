#Here is LR End function

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