class Stage
  include Enumerable
  attr_reader :width, :height, :start, :goal

  def initialize(options={})
    @width, @height = options['dimensions'] || [0, 0]

    raise InvalidDimensionsError if @width * @height == 0

    raise RequiredNodeError if options['start'].nil?
    raise RequiredNodeError if options['goal'].nil?

    @start = StartNode.new(options['start'])
    @goal = GoalNode.new(options['goal'])
    raise CollisionNodeError if @start == @goal

    @stage = Array.new(@width).map{|x| Array.new(@height)}

    raise OutOfBoundariesError if @start.out_of_bounds?([@width, @height])
    raise OutOfBoundariesError if @goal.out_of_bounds?([@width, @height])
    build_stage( options['wall'] )
  end

  def size
    @width * @height
  end

  def each
    @stage.each do |c|
      c.each do |r|
        yield r
      end
    end
  end


  def each_with_index
    index = 0
    @stage.each do |c|
      c.each do |r|
        yield r, index
        index += 1
      end
      index += 1
    end
  end

  def node_at(x, y)
    return nil if x <= 0 || x > width || y <= 0 || y > height
    @stage[x - 1][y - 1]
  end

  def []( index )
    raise OutOfBoundariesError if index < 1  || index > width
    @stage[ index - 1 ]
  end

  private

  def build_stage( wall )
    set_node( @start )
    set_node( @goal )
    
    wall.each do |wp|
      w = WallNode.new(wp)
      raise CollisionNodeError if w == @start or w == @goal
      raise OutOfBoundariesError if w.out_of_bounds?([@width, @height])
      set_node( w )
    end
    each_with_column_row do |n, x, y|
      set_node(  Node.new(x, y) ) if n.nil?
    end
  end

  def set_node( node )
    @stage[node.x - 1][node.y - 1] = node 
  end

  def each_with_column_row
    @stage.each_with_index do |x, col|
      x.each_with_index do |n, row|
        yield n, (col + 1), (row + 1)
      end
    end
  end

end
