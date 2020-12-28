require 'active_support'
require 'pry'

class Animal
  include ActiveSupport::Callbacks

  define_callbacks :sleep

  def sleep
    run_callbacks(:sleep) do
      puts '[sleeping]'
    end
  end
end

module DSL
  def before_sleep(&block)
    set_callback(:sleep, :before, &block)
  end

  def after_sleep(&block)
    set_callback(:sleep, :after, &block)
  end
end

class Cat < Animal
  extend DSL

  before_sleep do
    puts '寝るようです'
  end

  after_sleep do
    puts '寝ました'
  end
end

Cat.new.sleep

__END__
class Cat
  module SystemLoggable
    include ActiveSupport::Callbacks

    define_callbacks :sleep
    define_callbacks :eat

    set_callback(:sleep, :before) do
      puts '寝るようです'
    end

    set_callback(:sleep, :after) do
      puts '寝ました'
    end
  end

  include SystemLoggable

  def sleep
    run_callbacks(:sleep) do
      puts '...'
    end
  end

  def eat
    run_callbacks(:eat) do
      puts 'mogu mogu'
    end
  end
end
