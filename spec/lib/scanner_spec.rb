require 'spec_helper'

describe Scanner do
  include_context 'shared_data'

  context "#next_move" do
    it "responds to next_move" do
      robot = Robot.place_on_stage(Stage.new(stages['stage1']))
      subject = Scanner.new(robot)
      expect(subject).to respond_to :next_move
    end

    it "returns the nearest valid location" do
      robot = Robot.place_on_stage(Stage.new(stages['stage1']))
      subject = Scanner.new(robot)
      expect(subject.send(:find_best_location)).to be_an Node
    end

    it "returns the start point when robot can't move at all" do
      robot = Robot.place_on_stage(Stage.new(stages['stage4']))
      subject = Scanner.new(robot)
      expect(subject.send(:find_best_location)).to be_an StartNode
    end
  end
end
