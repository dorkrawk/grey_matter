class GreyMatter::NeuralNetwork

  @input_layer : Array(Node)
  @hidden_layers : Array(Array(Node))
  @output_layer : Array(Node)
  @edges = [] of Array(Edge)

  getter input_layer, hidden_layers, output_layer, edges

  def initialize(input_size : Int32, hidden_layer_sizes :  Array(Int32), output_size : Int32)
    @input_layer = build_layer(input_size)
    @hidden_layers = hidden_layer_sizes.map { |layer_size| build_layer(layer_size) }
    @output_layer = build_layer(output_size)
    build_edges
  end

  def train(input, output)
    raise ArgumentError.new("input must be the same size as the input layer") unless input.size == @input_layer.size
    raise ArgumentError.new("output must be the same size as the output layer") unless output.size == @output_layer.size
  end

  def reset!
    @edges.flatten.each { |e| e.reset }
  end

  def import(file)

  end

  def export(path)
    #export weights to file
  end

  def evaluate(input : Array(Float64))
    raise ArgumentError.new("input must be the same size as the input layer") unless input.size == @input_layer.size
    @input_layer.each_with_index { |node, i| node.value = input[i] }
    @hidden_layers.each { |layer| forward_propigate(layer) }
    forward_propigate(@output_layer)
    @output_layer.map { |node| node.value }
  end

  def forward_propigate(layer : Array(Node))
    layer.each do |node|
      node.value = @edges.flatten.select { |e| e.output == node }.map { |e| e.input.value * e.weight }.sum
    end
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
    all_nodes.each_cons(2) do |layers|
      @edges << connect_layers(layers.first, layers.last)
    end
  end

  def connect_layers(layer1 : Array(Node), layer2 : Array(Node))
    edges = [] of Edge
    layer1.each do |input_node|
      layer2.each do |output_node|
        edges << Edge.new(input_node, output_node)
      end
    end
    edges
  end

  def build_layer(size : Int32)
    layer = [] of Node
    size.times do
      layer << Node.new
    end
    layer
  end
end
