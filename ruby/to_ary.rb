class Item
  def respond_to?(name, visibility = false)
    p "respond to: #{name}"
    false # we don't respond to anything!!
  end

  def method_missing(name, *args)
    p "method missing: #{name}"
    super # if something?
    # do something else
  end
end

[[Item.new]].flatten
