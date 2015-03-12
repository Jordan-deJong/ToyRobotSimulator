class Robot

  def self.step(commands = {})
    #Catch locations
    safe_x = commands[:x]
    safe_y = commands[:y]

    #Change location
    case commands[:facing]
    when "North"
      commands[:y] += 1
    when "West"
      commands[:x] -= 1
    when "South"
      commands[:y] -= 1
    when "East"
      commands[:x] += 1
    end

    #Check new location for falling
    range = Rules.board_size
    unless range.cover?(commands[:x]) && range.cover?(commands[:y])
      commands[:x] = safe_x
      commands[:y] = safe_y
    end
    # Return commands
    commands
  end

  def self.turn(commands = {})
    # Find which way to turn
    turn = (commands[:direction] == "Right" ? Rules.right_facing_angles : Rules.left_facing_angles)
    # Change direction
    commands[:facing] = turn[commands[:facing].to_sym]
    # Return commands
    commands
  end

  def self.report(commands = {})
    # Return commands
    commands
  end

  def self.place(commands = {})
    # Return commands
    commands
  end

end
