#Here is LR Action function
#This part considering to abandon
module RoadRunnerModule

  def action(&blk)

    if block_given?

      @actBlk=blk
      register_transactions('actoin',&blk)
    else
      raise ArgumentError, "no block"
    end

  end

end
