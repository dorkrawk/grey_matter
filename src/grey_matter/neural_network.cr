class GreyMatter::NeuralNetwork

  def initialize(input_size : Int32, hidden_layer_sizes :  Array(Int32), output_size : Int32)
    @input_layer = build_layer(input_size)
    @hidden_layers = hidden_layer_sizes.map { |layer_size| build_layer(layer_size) }
    @output_layer = build_layer(output_size)
    build_edges
    # build network, set edge weights to random values
  end

  def train(input, output)

  end

  def reset
    # reset all edge weights to random values
  end

  def import(file)

  end

  def export(path)
    #export weights to file
  end

  def all_nodes
    [@input_layer] + @hidden_layers + [@output_layer]
  end

  def input_layer_index
    0
  end

  def output_layer_index
    all_nodes.size - 1
  end

  def build_edges
    @edges = [] of Array(GreyMatter::Edge)
    all_nodes.each_with_index do |layer, i|
      @edges << connect_layers(layer, all_nodes[i+1]) if i -1 < all_nodes.size
    end
  end

  def connect_layers(layer1 : Array(GreyMatter::Node), layer2 : Array(GreyMatter::Node))
    edges = [] of GreyMatter::Edge
    layer1.each do |input_node|
      layer2.each do |output_node|
        edges << Edge.new(input_node, output_node)
      end
    end
    edges
  end

  def build_layer(size : Int32)
    layer = [] of Float64
    size.times do
      layer << Node.new
    end
    layer
  end
end
