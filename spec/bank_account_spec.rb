require 'bank_account'

describe BankAccount do
  let (:bank_account) { BankAccount.new }
  
  it { is_expected.to be_instance_of BankAccount }

  describe '#get_balance' do
    it 'returns initial balance of new bank account' do
      expect(bank_account.get_balance).to eq 0
    end
  end

  describe '#add_to_balance' do
    it 'adds 1000 to the balance' do
      bank_account.add_to_balance(1000)
      expect(bank_account.get_balance).to eq 1000
    end
  end
end