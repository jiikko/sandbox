class Cat
  def eat
    [setup, run].join(', ')
  end

  private

  def setup
  end

  def run
  end
end

require 'logger'
require "minitest/autorun"
require 'minitest/power_assert'
require 'minitest/stub_any_instance'
require 'pry'









logger = Logger.new($stdout)
class Hoge
  def run
    internal
  end

  def internal
    'hello'
  end
end

describe Cat do
  it 'aaaaaaaaaaaaa' do

Hoge.stub_any_instance :internal, 'hello from mock' do 
  Hoge.new.run # => 'hello from mock'
end
Hoge.new.run # => 'hello'
    binding.pry
    hoge = Hoge.new
    mock = Minitest::Mock.new.expect(:call, true, [])
    hoge.stub :internal, mock do 
      hoge.run # => 'hello from mock'
    end
    mock.verify

    mock = Minitest::Mock.new.expect(:callk, true, [])
    Hoge.stub_any_instance :internal, mock do 
      puts Hoge.new.run # => 'hello from mock'
    end
    mock.verify

  end
  it 'mock String#size' do
    mock = Minitest::Mock.new.expect(:call, true, [])
    Hoge.stub_any_instance(:internal, mock) do
      Hoge.new.run
    end
    mock.verify
  end

  describe '#eat' do
    describe 'with stub_any_instance' do 
      it 'call #setup from internal' do
        mock = Minitest::Mock.new.expect(:call, true, [])
        # mock = proc { raise 'tset' }
        Cat.stub_any_instance :setup, mock do
          Cat.new.eat
        end
        mock.verify
      end

      it 'stub two method' do
      end
    end
    describe 'with stub' do 
      it 'call #setup from internal' do
        cat = Cat.new
        mock = Minitest::Mock.new.expect(:call, true, [])
        cat.stub :setup, mock do 
          cat.eat 
        end
        mock.verify
      end
      it 'stub two method' do
        cat = Cat.new
        cat.stub :setup, 'setup method was called me from stub' do
          logger.info(cat.eat)
          cat.stub :run, 'run method was called me from stub' do
            logger.info(cat.eat)
          end
        end
      end
    end
  end
end
