Parallel.new(shared_list: ["/hhh", "/gdjf"], concurrency: 4) { |url|
  some_run(url)
}

Parallel.new(["/hhh", "/gdjf"], concurrency: 2) { |url|
  some_run(url)
}






MyParallel
