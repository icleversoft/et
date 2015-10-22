require 'spec_helper'

describe Node do
  context "valid node" do
    let(:node){Node.new(3, 4)}
    it "x takes the right value" do
      expect(node.x).to eq 3
    end

    it "y coordinate is an integer" do
      expect(node.y).to eq 4
    end

    it "is not an 'goal' node" do
      expect(node.is_goal?).to be_falsey
    end

    it "is not a 'start' node" do
      expect(node.is_start?).to be_falsey
    end

    it "it's weight is initially 5" do
      expect(node.weight).to eq 5
    end


    context "#visit!" do
      it "changes the visit attribute correctly" do
        node.visit!
        expect(node.visited?).to be_truthy
      end

      it "decreases node's weight by one" do
        expect{node.visit!}.to change(node, :weight).by(-1)
      end
    end



    it "detects correctly if node is out of given bounds" do
      expect(node.out_of_bounds?([4, 3])).to be_truthy
      expect(node.out_of_bounds?([3, 5])).to be_falsey
      expect(node.out_of_bounds?([2, 2])).to be_truthy
    end

    context "#up!" do
      it "changes y correctly" do
        expect{node.up!}.to change(node, :y).by(1)
      end
      it "doesn't change x" do
        expect{node.up!}.not_to change(node, :x).from(3)
      end
    end
    context "#left!" do
      it "changes x correctly" do
        expect{node.left!}.to change(node, :x).by(-1)
      end
      it "doesn't change y" do
        expect{node.left!}.not_to change(node, :y).from(4)
      end
    end
    context "#right!" do
      it "changes x correctly" do
        expect{node.right!}.to change(node, :x).by(1)
      end
      it "doesn't change y" do
        expect{node.right!}.not_to change(node, :y).from(4)
      end
    end
    context "#down!" do
      it "changes y correctly" do
        expect{node.down!}.to change(node, :y).by(-1)
      end
      it "doesn't change x" do
        expect{node.up!}.not_to change(node, :x).from(3)
      end
    end
  end

  context "#<=>" do
    let(:node1){Node.new(1,1)}
    let(:node2){StartNode.new(1,1)}
    let(:node3){GoalNode.new(1,1)}

    it "simple node a larger weight than startnode" do
      expect( node1 <=> node2).to  eq(1) 
    end

    it "goal value has the largest weight" do
      expect( node3 <=> node1 ).to eq(1)
      expect( node3 <=> node2 ).to eq(1)
    end
  end

  context "#to_s" do
    let(:node){Node.new(3, 4)}
    it "returns correctly its coordinates in a string" do
      expect(node.to_s).to eq "3, 4"
    end
  end


  context "invalid node" do
    it "0, 0 is an invalid node" do
      expect{Node.new(0, 0)}.to raise_error InvalidNodeError
    end

    it "both coordinates should be positive integers" do
      expect{Node.new(3, -1)}.to raise_error InvalidNodeError
      expect{Node.new(-3, 1)}.to raise_error InvalidNodeError
    end
  end
end


describe StartNode do
  let(:node){StartNode.new(2,3)}
  it "is actually a node" do
    expect(node).to be_an Node
  end

  it "is actually a 'start' node" do
    expect(node.is_start?).to be_truthy
  end

  it "is not an 'goal' node" do
    expect(node.is_goal?).to be_falsey
  end

  it "is not a 'wall' node" do
    expect(node.is_wall?).to be_falsey
  end

  it "responds to out_of_bounds?" do
    expect(node).to respond_to :out_of_bounds?
  end

  it "it's weight is initially 4" do
    expect(node.weight).to eq 4
  end

end

describe GoalNode do
  let(:node){GoalNode.new(2,3)}
  it "is actually a node" do
    expect(node).to be_an Node
  end

  it "is actually an 'goal' node" do
    expect(node.is_goal?).to be_truthy
  end

  it "is not a 'start' node" do
    expect(node.is_start?).to be_falsey
  end

  it "is not a 'wall' node" do
    expect(node.is_wall?).to be_falsey
  end

  it "it's weight is 10" do
    expect(node.weight).to eq 10 
  end
end

describe WallNode do
  let(:node){WallNode.new(2,3)}
  it "is actually a node" do
    expect(node).to be_an Node
  end

  it "is actually a 'wall' node" do
    expect(node.is_wall?).to be_truthy
  end

  it "is not a 'start' node" do
    expect(node.is_start?).to be_falsey
  end

  it "is not an 'end' node" do
    expect(node.is_goal?).to be_falsey
  end

  it "it's weight is 0" do
    expect(node.weight).to eq 0
  end
end
