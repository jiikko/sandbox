module First
  def name
    'john'
  end
end
module Second
  def name
    'jr'
  end
end
class Hello; end
puts Hello.new.extend(First).extend(Second).name # jr
puts Hello.new.extend(Second).extend(First).name # john

module First
  def name
    'john'
  end
end
module Second
  def name
    super() + 'jr'
  end
end
class Hello; end
puts Hello.new.extend(First).extend(Second).name # johnjr
