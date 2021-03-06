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
    calculated_output = evaluate(input)

    # do this for one node...
    # output -> last hidden layer
    node_calculated_output = calculated_output.first
    output_node = @output_layer.first
    node_actual_output = output.first
    margin_of_error = node_actual_output - node_calculated_output
    output_sum = calculate_input_influence(output_node)
    delta_output_sum = Math.sigmoid_function_prime(output_sum) * margin_of_error
    delta_weights_ouput = input_edges(output_node).map { |e| e.input.value * delta_output_sum }
    # last hidden layer -> 2nd to last hidden layer or input
    delta_output_sum_x_hidden_to_outer_weights = input_edges(output_node).map { |e| e.weight * delta_output_sum }
    sigma_prime_hidden_sum = @hidden_layers.last.map { |n| n.input_influence }
    delta_hidden_sum = Math.matrix_mul(delta_output_sum_x_hidden_to_outer_weights, sigma_prime_hidden_sum)
    input_values = @input_layer.map { |n| n.value }
    delta_weights_hidden_first = Math.matrix_scalar(delta_hidden_sum, input_values.first)
    # need to continue here...

    # --------------

  end

  def back_propigate(input, output, result_nodes)
    # refer to http://stevenmiller888.github.io/mind-how-to-build-a-neural-network-part-2/
    error_output_layer = Math.matrix_sub(output, result_nodes[output_layer_index].map(&:value) )
    delta_output_layer = Math.matrix_mul(result_nodes[output_layer_index].map(&:input_influence), error_output_layer)
    output_layer_input_change = Math.matrix_scalar(Math.matrix_mul(delta_output_layer, hidden_layers.last.map(&:value)), learning_rate)

    layer_index = output_layer_index
    while layer_index > input_layer_index do

    end
  end

  def train_from_set(input_set, output_set)

  end

  def reset!
    @edges.flatten.each { |e| e.reset }
  end

  def import(file)

  end

  def export(path)
    #export weights to file
  end

  def evaluate(input : Array(Int32))
    float_input = input.map { |i| i.to_f64 }
    evaluate(float_input)
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
      input_influence = calculate_input_influence(node)
      node.input_influence = input_influence
      node.value = activation_function(input_influence)
    end
  end

  def calculate_input_influence(node : Node)
    input_edges(node).map { |e| e.input.value * e.weight }.sum
  end

  def input_edges(node : Node)
    @edges.flatten.select { |e| e.output == node }
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

  def activation_function(value)
    Math.sigmoid_function(value)
  end

  def activation_function_prime(value)
    Math.sigmoid_function_prime(value)
  end

  def learning_rate
    0.7 # why? i don't know
  end
end
