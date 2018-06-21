class Transaction
  attr_reader :tx_id, :inputs, :outputs

  def initialize(args)
    @inputs = args[:inputs]
    @outputs = args[:outputs]
    @tx_id = args[:tx_id]
  end

  def self.base_transaction
  end
end
