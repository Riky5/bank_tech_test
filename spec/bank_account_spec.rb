require 'bank_account'
require 'date'

describe BankAccount do
  let(:bank_account) { BankAccount.new }
  let(:faketoday) { Date.new(2022, 01, 31).strftime('%d/%m/%Y') }

  describe '#get_balance' do
    it 'returns initial balance of new bank account' do
      expect(bank_account.read_balance).to eq 0
    end
  end

  describe '#add_to_balance' do
    it 'adds 1000 to the balance' do
      bank_account.add_to_balance(1000)
      expect(bank_account.read_balance).to eq 1000
    end

    it 'produces a transaction with 31/01/2022, 1000, 1000 details' do
      bank_account.add_to_balance(1000, faketoday)
      expect(bank_account.transactions).to include({ :date => '31/01/2022', :credit => 1000, :balance => 1000 })
    end
  end

  describe '#remove_from_balance' do
    it 'removes 500 from the balance' do
      bank_account.add_to_balance(1000)
      bank_account.remove_from_balance(500)
      expect(bank_account.read_balance).to eq 500
    end

    it 'produces a transaction with date, amount, balance details' do
      bank_account.add_to_balance(1000)
      bank_account.remove_from_balance(200, faketoday)
      p bank_account
      expect(bank_account.transactions).to include({ :date => '31/01/2022', :debit => 200, :balance => 800 })
    end
  end
end
