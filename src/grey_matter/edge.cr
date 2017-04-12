class GreyMatter::Edge

  property input, output, weight

  def initialize(@input : GreyMatter::Node, @output : GreyMatter::Node, initial_weight : Float64 = nil)
    @weight = initial_weight || Random.rand
  end
end
