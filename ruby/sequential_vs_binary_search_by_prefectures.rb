require 'benchmark'

def prefecture_ids
  (1..47).to_a
end

def sequential_search(id)
  prefecture_ids.find { |prefecture_id| prefecture_id == id }
end

def binary_search(id)
  prefecture_ids.bsearch { |prefecture_id| prefecture_id == id }
end


# 要素が見つかる時
Benchmark.bm do |bm|
  bm.report 'binary_search'.ljust(15) do
    100.times do
      (1..47).each do |id|
        binary_search(id)
      end
    end
  end

  bm.report 'sequential'.ljust(15) do
    100.times do
      (1..47).each do |id|
        sequential_search(id)
      end
    end
  end
end

# user     system      total        real
# binary_search    0.010000   0.000000   0.010000 (  0.013782)
# sequential       0.030000   0.000000   0.030000 (  0.030816)

# 要素が見つからない時
Benchmark.bm do |bm|
  bm.report 'binary_search'.ljust(15) do
    100.times do
      (47..90).each do |id|
        binary_search(id)
      end
    end
  end

  bm.report 'sequential'.ljust(15) do
    100.times do
      (47..90).each do |id|
        sequential_search(id)
      end
    end
  end
end
# user     system      total        real
# binary_search    0.010000   0.000000   0.010000 (  0.013862)
# sequential       0.030000   0.000000   0.030000 (  0.033669)
