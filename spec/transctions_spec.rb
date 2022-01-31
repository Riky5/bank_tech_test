require 'transactions'

describe Transactions do
  let(:transactions) { Transactions.new }

  describe '#read_transaction' do
    it 'returns an empty array when initialized' do
      expect(transactions.read_transaction).to eq []
    end
  end
end