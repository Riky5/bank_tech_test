require 'bank_account'

describe BankAccount do
  let (:bank_account) { BankAccount.new }
  
  it { is_expected.to be_instance_of BankAccount }

  describe '#get_balance' do
    it 'returns initial balance of new bank account' do
      expect(bank_account.get_balance).to eq 0
    end
  end
end