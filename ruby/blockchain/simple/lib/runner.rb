require_relative 'load'
require 'pry'

class Runner
  def initialize
    @miners = []
    @shared_block_chain = BlockChain.new
    @miners_threads = []
  end

  def run
    puts 'start!'
    create_miner(name: 'kenjii')
    create_miner(name: 'tomoe')
    create_miner(name: 'test')
    @miners_threads.each(&:join)

    puts '--------------'
    puts @shared_block_chain.blocks.map { |x| "#{x.data}:#{x.hash}" }.join("\n")
  end

  private

  def create_miner(name: )
    @miners_threads << Thread.start do
      miner = Miner.new(name: name)
      @miners << miner
      3.times do |i|
        rand_int = [1, 2, 3].sample
        sleep(rand_int)
        miner.accept(@shared_block_chain)
        rand_int.times do
          miner.add_new_block
        end
        broadcast(miner)
      end
    end
  end

  def broadcast(miner)
    puts "#{miner.name} broadcasted"
    @shared_block_chain = miner.block_chain
  end
end
