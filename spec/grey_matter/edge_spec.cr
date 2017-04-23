require "../../spec_helper"

describe GreyMatter::Edge do

  describe ".initialize" do

    it "sets an initial_weight" do
      node1 = GreyMatter::Node.new
      node2 = GreyMatter::Node.new
      edge = GreyMatter::Edge.new(node1, node2)
      edge.weight.should_not be_nil
    end
  end
end
