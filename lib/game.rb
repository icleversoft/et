require 'errors'
require 'node'
require 'stage'
require 'robot'
require 'scanner'
require 'yaml'

class Game 
  attr_reader :robot
  class << self
    def from_file( file )
      raise LoadError unless File.exist? file
      Game.new( YAML.load_file( file ) )
    end
  end

  def initialize( data = {} )
    @robot = nil
    unless data.empty?
      @robot = Robot.place_on_stage(Stage.new(data['maze'])) 
    end
   rescue => e
     print e.class
    @robot = nil
  end

  def run
    if @robot.nil?
      print "\n\nCheck out file contents and retry!\n"
    else
      print_info
      print "\rSearching..."

      @robot.find_goal
      if @robot.location.is_start?
        print "\rNot found :-/\n\n\n"
      elsif @robot.location.is_goal?
        print "\rGoal found at (#{@robot.location.to_s}) :-]\n\n\n"
      end
    end
  end
  private

  def print_info
      print "\n\n"
      print "- - - - - - - - - - - - - - - - - - - - - \n"
      print "Maze size....: #{@robot.stage.width} x #{@robot.stage.height}\n"
      print "Start Point..: (#{@robot.location.to_s})\n"
      print "Goal Point...: (#{@robot.stage.goal.to_s})\n"
      print "- - - - - - - - - - - - - - - - - - - - - \n"
  end
end

