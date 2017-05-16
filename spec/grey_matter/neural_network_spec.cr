require "../../spec_helper"

describe GreyMatter::NeuralNetwork do
  input_size = 2
  hidden_sizes = [3]
  output_size = 1

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
      input = [1.0, 1.0]
      nn.evaluate(input)
    end

    it "raises an ArgumentError if the input doesn't match the size of the input layer" do
      nn = GreyMatter::NeuralNetwork.new(input_size, hidden_sizes, output_size)
      input = [1.0, 1.0, 1.0]
      expect_raises(ArgumentError) do
        nn.evaluate(input)
      end
    end
  end

  describe "#train" do
    it "something" do
      nn = GreyMatter::NeuralNetwork.new(input_size, hidden_sizes, output_size)
      nn.activation_function(4)
    end

    it "converges on a reasonable solution to XOR" do
      nn = GreyMatter::NeuralNetwork.new(2, [3], 1)
      # XOR
      100.times do
        nn.train([0,0],[0])
        nn.train([0,1],[1])
        nn.train([1,0],[1])
        nn.train([1,1],[0])
      end
      nn.evaluate([0,0]).first.should be_close(0, 0.01)
      nn.evaluate([0,1]).first.should be_close(1, 0.01)
      nn.evaluate([1,0]).first.should be_close(1, 0.01)
      nn.evaluate([1,1]).first.should be_close(0, 0.01)
    end
  end
end
