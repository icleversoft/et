class Scanner
  attr_reader :robot

  def initialize( robot )
    @robot = robot 
  end

  def next_move(on_continue, on_goal, no_solution)
    node = find_best_location
    if node.is_start?
      no_solution.call(node)
    elsif node.is_goal?
      on_goal.call(node)
    else
      on_continue.call(node)
    end
  end

  def method_missing(method_name, *args)
    if method_name.match(/location/)
      robot.location
    elsif method_name.match(/stage/)
      robot.stage
    else
      super
    end
  end

  private

  def find_best_location
    nodes = []
    Robot::DIRECTIONS.each do |direction|
      x, y = [location.x, location.y]
      case direction
      when :up
        y += 1 
      when :down
        y -= 1 
      when :left
        x -= 1 
      when :right
        x += 1 
      end
      node = stage.node_at(x, y)
      unless node.nil?
        if node.is_node?
          nodes << node
        elsif node.is_goal?
          return node
        elsif node.is_start?
          nodes << node
        end
      end
    end
    nodes << location if nodes.empty?
    nodes.sort!{|a,b| b<=>a}.first
  end
end
