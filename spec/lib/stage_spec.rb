require 'spec_helper'

describe Stage do
  include_context 'shared_data'

  context "valid stage" do
    let(:stage){Stage.new(stages["stage1"])}
    it "raises an error when invalid stage dimensions are given" do
      expect{subject}.to raise_error InvalidDimensionsError
    end

    it "calculates correctly the width of stage" do
      expect(stage.width).to eq 8
    end

    it "calculates correctly the height of stage" do
      expect(stage.height).to eq 6
    end

    it "calculates correctly stage's dimensions" do
      expect(stage.size).to eq 48
    end

    context 'start node' do
      it "should be a StartNode instance" do
        expect(stage.start).to be_an StartNode
      end

      it "should have the right cooordinates" do
        expect(stage.start.x).to eq 1
        expect(stage.start.y).to eq 1
      end
    end

    context 'end node' do
      it "should be an GoalNode instance" do
        expect(stage.goal).to be_an GoalNode
      end

      it "should have the right cooordinates" do
        expect(stage.goal.x).to eq 6
        expect(stage.goal.y).to eq 6
      end

      it "responds to each" do
        expect(stage).to respond_to(:each)
      end

      it "responds to each_with_index" do
        expect(stage).to respond_to(:each_with_index)
      end

      it "all its nodes are instance of node" do
        stage.each do |n|
          expect(n).to be_an Node
        end
      end
    end 

    it "should not have the same coordinates as the 'end' node" do
      expect(stage.start).not_to eq(stage.goal)
    end

    context "#node_at" do
      it "return nil when point is out of bounds" do
        expect(stage.node_at(0, 1)).to be_nil 
        expect(stage.node_at(1, 10)).to be_nil
      end

      it "returns correctly the 'start' node" do
        expect(stage.node_at(1, 1)).to eq(stage.start)
      end

      it "returns correctly the 'end' node" do
        expect(stage.node_at(6, 6)).to eq(stage.goal)
      end

      it "returns correctly any of the wall nodes" do
        expect(stage.node_at(2, 3)).to be_an WallNode
      end
    end
     
    context "#[]" do
      it "raises an error when index is out of bounds" do
        expect{stage[0]}.to raise_error OutOfBoundariesError
        expect{stage[10]}.to raise_error OutOfBoundariesError
      end
      it "returns an array when index is correct" do
        expect(stage[1]).to be_an Array
      end
    end
  end

  it "should raise an error when start point is not given" do
    expect{Stage.new(stages["start_is_not_given"])}.to raise_error RequiredNodeError
  end 

  it "should raise an error when goal point is not given" do
    expect{Stage.new(stages["goal_is_not_given"])}.to raise_error RequiredNodeError
  end 

  it "should raise an error when start point is on the goal" do
    expect{Stage.new(stages["start_end_collision"])}.to raise_error CollisionNodeError
  end

  it "raises an error when start point is out of stage" do
    expect{Stage.new(stages["start_outside"])}.to raise_error OutOfBoundariesError
  end

  it "raises an error when a wall point is outside of stage" do
    expect{Stage.new(stages["wall_outside"])}.to raise_error OutOfBoundariesError
  end

  it "raises an error when end point is out of stage" do
    expect{Stage.new(stages["end_outside"])}.to raise_error OutOfBoundariesError
  end
  
  it "raises an error when a wall point contains the end point" do
    expect{Stage.new(stages["start_into_wall"])}.to raise_error CollisionNodeError
  end

  it "raises an error when a wall point contains the start point" do
    expect{Stage.new(stages["end_into_wall"])}.to raise_error CollisionNodeError
  end

end

