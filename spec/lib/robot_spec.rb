require 'spec_helper'

describe Robot do
  include_context 'shared_data'
  let(:stage){Stage.new(stages['stage1'])}
  let(:robot){Robot.place_on_stage(stage)}

  context "initialization" do
    it "its initial location is a StartNode" do
      expect(robot.location).to be_an StartNode
    end

    it "stage should be actually a Stage instance" do
      expect(robot.stage).to be_an Stage
    end
  end

  it "raise an error if none initial placement is set" do
    expect{subject}.to raise_error RobotInvalidStage
  end

  context "#find_solution" do

    it "finds the goal starting from the bottom left point" do
      stage = Stage.new(stages['stage1'])
      robot = Robot.place_on_stage( stage )
      robot.find_goal
      expect(robot.location).to eq(stage.goal)
      expect(robot.location.to_s).to eq "6, 6"
    end

    it "finds the goal starting from an inner position" do
      stage = Stage.new(stages['stage2'])
      robot = Robot.place_on_stage( stage )
      robot.find_goal
      expect(robot.location).to eq(stage.goal)
      expect(robot.location.to_s).to eq "2, 3"
    end

    it "goal didn't found due to the wall" do
      stage = Stage.new(stages['stage3'])
      robot = Robot.place_on_stage( stage )
      robot.find_goal
      expect(robot.location).to eq(stage.start)
      expect(robot.location.to_s).to eq "4, 2"
    end

    it "robot can't actually move" do
      stage = Stage.new(stages['stage4'])
      robot = Robot.place_on_stage( stage )
      robot.find_goal
      expect(robot.location).to eq(stage.start)
      expect(robot.location.to_s).to eq "3, 2"
    end
  end
end
