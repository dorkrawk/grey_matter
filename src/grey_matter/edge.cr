class GreyMatter::Edge

  property input, output, weight

  def initialize(@input : GreyMatter::Node, @output : GreyMatter::Node)
    @weight = Random.rand
  end

  def reset
    @weight = Random.rand
  end
end
