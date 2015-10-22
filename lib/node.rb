class Node
  TYPES = [:node, :start, :wall, :goal]
  POINT_IN_BOUNDS=->(pt, bounds){(1..bounds).to_a.include?(pt)}
  attr_reader :x, :y, :weight

  def initialize( *args  )
    args ||= [0, 0]
    args.flatten!
    @x, @y = [args[0].to_i, args[1].to_i]
    raise InvalidNodeError if @x <= 0 or @y <= 0
    @visited = false
    @weight = 5
  end

  def == (other)
    x == other.x && y == other.y
  end

  TYPES.each do |type|
    define_method "is_#{type}?" do
      prefix = self.class.to_s[/.[^N]+/]
      type.to_s == prefix.downcase
    end
  end
 
  def <=> (other )
    self.weight <=> other.weight
  end

  def visited?
    @visited
  end

  def visit!
    @visited = true if !visited?
    @weight -=1
  end

  def out_of_bounds? bounds
    !POINT_IN_BOUNDS.call(x, bounds[0]) || !POINT_IN_BOUNDS.call(y, bounds[1])
  end

  def up!
    @y += 1
  end

  def down!
   raise InvalidNodeError if @y == 1 
    @y -= 1
  end

  def left!
    raise InvalidNodeError if @x == 1
    @x -= 1
  end

  def right!
    @x += 1
  end

  def to_s
    [@x, @y].join(', ')
  end
end

class StartNode < Node
  def initialize( *args )
    super( args )
    @weight = 4
  end
end

class GoalNode < Node
  def initialize( *args )
    super( args )
    @weight = 10
  end
end

class WallNode < Node
  def initialize( *args )
    super( args )
    @weight = 0
  end
end
