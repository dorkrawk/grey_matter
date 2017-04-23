require "../../spec_helper"

describe GreyMatter::NeuralNetwork do
  input_size = 5
  hidden_sizes = [4, 3]
  output_size = 2

  describe ".initialize" do

    it "builds layers of the given size" do
      nn = GreyMatter::NeuralNetwork.new(input_size, hidden_sizes, output_size)
      nn.input_layer.size.should eq input_size
      nn.hidden_layers.map { |l| l.size }.should eq hidden_sizes
      nn.output_layer.size.should eq output_size
    end
  end

  describe "#evaluate" do

    it "takes input and produces output based on current weights" do
      nn = GreyMatter::NeuralNetwork.new(input_size, hidden_sizes, output_size)
      nn.edges.flatten.each { |e| e.weight = 0.5}
      input = [1.0, 1.0, 1.0, 1.0, 1.0]
      nn.evaluate(input).should eq [7.5, 7.5]
    end

    it "raises an ArgumentError if the input doesn't match the size of the input layer" do
      nn = GreyMatter::NeuralNetwork.new(input_size, hidden_sizes, output_size)
      input = [1.0, 1.0]
      expect_raises(ArgumentError) do
        nn.evaluate(input)
      end
    end
  end
end
