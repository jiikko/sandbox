# TODO
# * 無限ループ
# users.original_bsearch(3) { |user| user.id == 3 }

module BinarySearchModule
  def original_bsearch(wip_list = {})
    min = 0
    max = self.size - 1
    current_position = (max / 2).to_i
    loop do
      result = yield(self[current_position])
      if result
        max = current_position
        current_position = ((min + max) / 2).to_i
      else
        min = current_position
        current_position = ((min + max) / 2).to_i
      end

      if result && !yield(self[current_position - 1])
        return self[current_position]
      end
    end
  end
end

class User
  attr_accessor :id
  def initialize(id)
    self.id = id
  end
end
users = 10.times.map { |x| User.new(x) }
users.extend(BinarySearchModule)
# users.bsearch { |user| user.id >= 4 }
users.original_bsearch(3) { |user| user.id >= 8 }
users.original_bsearch(3) { |user| user.id >= 3 }
