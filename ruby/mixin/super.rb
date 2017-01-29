class Animal
  def type
    'h_'
  end
end

class Cat < Animal
  def type
    puts super + 'cat'
  end
end

module Language
  def type
    'Language'
  end
end
puts Cat.ancestors
Cat.new.type # h_cat

Cat.prepend(Language) # [Language, Cat, Animal, Object, Kernel, BasicObject]
Cat.new.type # Language

Cat.include(Language) # [Cat, Language, Animal, Object, Kernel, BasicObject]
Cat.new.type # Languagecat



class Animal
  def type
    'h_'
  end
end

class Cat < Animal
  def type
    super + 'cat'
  end
end

module Language
  def type
    "#{super}_Language"
  end
end

Cat.prepend(Language) # [Language, Cat, Animal, Object, Kernel, BasicObject]
Cat.new.type # h_cat_Language


Cat.include(Language) # [Cat, Language, Animal, Object, Kernel, BasicObject]
Cat.new.type # h__Languagecat
