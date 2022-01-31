require 'bank'

describe Bank do
  let(:bank) { Bank.new(bank_account) }
  let(:bank_account) { double('bank_account') }

  describe '#make_deposit' do
    it 'adds 1000 into bank account' do
      allow(bank_account).to receive(:add_to_balance).with(1000)
      allow(bank_account).to receive(:get_balance).and_return(1000)
      bank.make_deposit(1000)
      expect(bank.account.get_balance).to eq 1000
    end
  end
end