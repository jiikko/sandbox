class Tree::Node
  module Formatable
    def nodes_with_to_i
      [ nodes[0].nil? ? nil : nodes[0].to_i,
        nodes[1].nil? ? nil : nodes[1].to_i,
      ]
    end

    def nodes_with_to_s
      [ nodes[0].to_s,
        nodes[1].to_s,
      ]
    end

    def to_s
      myself.to_s
    end

    def to_i
      myself
    end
  end
end
