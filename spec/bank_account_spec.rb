require 'bank_account'
require 'date'

describe BankAccount do
  let(:bank_account) { BankAccount.new(500) }

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

    it 'creates a transaction with date: 31/01/2022, credit: 1000, balance: 2000' do
      fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')
      bank_account.add_to_balance(1000, fakedate)
      expect(bank_account.transactions).to include({ date: '31/01/2022', credit: 1000, debit: 0, balance: 2000 })
    end
  end

  describe '#remove_from_balance' do
    it 'deducts 500 from the balance' do
      bank_account.remove_from_balance(500)
      expect(bank_account.read_balance).to eq 500
    end

    it 'creates a transaction with date, debit amount and balance' do
      fakedate = Date.new(2022, 1, 30).strftime('%d/%m/%Y')
      bank_account.remove_from_balance(200, fakedate)
      expect(bank_account.transactions).to include({ date: '30/01/2022', credit: 0, debit: 200, balance: 800 })
    end

    context 'it allows a pre-set overdraft'
    it 'deducts 1500 from balance of 1000' do
      bank_account.remove_from_balance(1500)
      expect(bank_account.read_balance).to eq -500
    end

    it 'raise error when trying to deduct more than overdraft limit' do
      bank_account.remove_from_balance(1000)
      expect { bank_account.remove_from_balance(600) }.to raise_error 'Denied! You cannot withdraw more than your overdraft limit!'
    end
  end
end
