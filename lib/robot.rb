class Robot
  attr_accessor :location
  attr_reader :stage

  DIRECTIONS = [:up, :down, :left, :right] 

  class << self

    def place_on_stage( stage )
      Robot.new( stage )
    end
  end

  def find_goal
    return if @location.is_goal?

    on_goal=->(new_location){move_to_location(new_location)}#Goal found!
    on_continue=->(new_location){move_to_location(new_location)}#Goal not found, continue!
    no_solution=->(new_location){move_to_location(new_location)}#Goal can't be found at all

    @scanner.next_move(on_continue, on_goal, no_solution)
  end

  protected

  def move_to_location( new_location )
    @location = new_location
    @location.visit!
    find_goal if  @location.is_node?
  end

  def initialize( stage = nil )
    raise RobotInvalidStage if !stage.is_a? Stage 

    @stage = stage
    @location =  stage.start 
    @location.visit!
    @scanner = Scanner.new( self )
  end

end
