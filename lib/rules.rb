class Rules

  def self.board_size
    0..4
  end

  def self.valid_movements
    ["place", "step", "turn", "report", ""]
  end

  def self.valid_turning_directions
    ["Left", "Right", ""]
  end

  def self.valid_facings
    ["North", "South", "West", "East", ""]
  end

  def self.left_facing_angles
    {North: "West", East: "North", South: "East", West: "South"}
  end

  def self.right_facing_angles
    {North: "East", East: "South", South: "West", West: "North"}
  end

end
