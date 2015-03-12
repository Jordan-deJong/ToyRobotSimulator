class Errors

  def self.check(commands)
    @errors = []
    # Check movement called
    @errors << "Invalid movement." unless Rules.valid_movements.include? commands[:move]
    # Check turn direction
    @errors << "Invalid turning direction." unless Rules.valid_turning_directions.include? commands[:direction]
    # Check facing direction
    @errors << "Invalid facing direction." unless Rules.valid_facings.include? commands[:facing]
    # Check location of x and y
    {x: commands[:x], y: commands[:y]}.each do |key, value|
      @errors << "Invalid position #{key.to_s}, needs to be between 0 and 4." unless Rules.board_size.cover? value
    end
    @errors
  end

end
