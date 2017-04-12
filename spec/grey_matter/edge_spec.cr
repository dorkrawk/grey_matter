require "../../spec_helper"

describe GreyMatter::Edge do

  describe ".initialize" do

    it "sets an initial_weight" do
      node1 = GreyMatter::Node.new
      node2 = GreyMatter::Node.new
      edge = GreyMatter::Edge.new(node1, node2, 0.3)
      edge.weight.should eq(0.3)
    end
  end
end
