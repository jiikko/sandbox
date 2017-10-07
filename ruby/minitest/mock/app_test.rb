class Cat
  def eat
    setup
    run
  end

  private

  def setup
  end

  def run
  end
end

require 'logger'
require 'minitest/power_assert'
require "minitest/autorun"

logger = Logger.new($std)

describe Cat do
  describe '#eat' do
    describe 'with stub_any_instance' do 
    end
    describe 'with stub' do 
      it 'it call #setup on internal' do
        cat = Cat.new
        cat.stub :eat, 'I was called me from mock' do
        # cat.stub :eat, Proc.new{ puts 'I was called me from mock' } do
          logger.error(cat.eat)
        end
      end
    end
  end
end
