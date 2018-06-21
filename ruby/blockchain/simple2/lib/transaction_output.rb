class TransactionOutput
  attr_reader :value, :script_pubkey

  def initialize(args)
    @value = args[:value]
    @script_sig = args[:script_pubkey]
end
