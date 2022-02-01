require 'bank_account'
require 'date'

describe BankAccount do
  let(:bank_account) { BankAccount.new }

  before :each do |example|
    bank_account.add_to_balance(1000) unless example.metadata[:skip_before]
  end

  describe '#get_balance' do
    it 'returns initial balance of new bank account', :skip_before do
      expect(bank_account.read_balance).to eq 0
    end
  end

  describe '#add_to_balance' do
    it 'adds 1000 to the balance' do
      bank_account.add_to_balance(1000)
      expect(bank_account.read_balance).to eq 2000
    end

    it 'creates a transaction with 31/01/2022, 1000, 2000 details' do
      fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')
      bank_account.add_to_balance(1000, fakedate)
      expect(bank_account.transactions).to include({ date: '31/01/2022', credit: 1000, debit: 0, balance: 2000 })
    end
  end

  describe '#remove_from_balance' do
    it 'removes 500 from the balance' do
      bank_account.remove_from_balance(500)
      expect(bank_account.read_balance).to eq 500
    end

    it 'creates a transaction with date, amount, balance details' do
      fakedate = Date.new(2022, 1, 30).strftime('%d/%m/%Y')
      bank_account.remove_from_balance(200, fakedate)
      expect(bank_account.transactions).to include({ date: '30/01/2022', credit: 0, debit: 200, balance: 800 })
    end
  end
end
