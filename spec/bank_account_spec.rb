require 'bank_account'

describe BankAccount do
  let(:bank_account) { BankAccount.new(500) }

  before :each do |example|
    fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')
    bank_account.add_to_balance(1000, fakedate) unless example.metadata[:skip_before]
  end

  describe '#add_to_balance' do
    it 'adds 1000 to the balance' do
      fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')
      bank_account.add_to_balance(1000, fakedate)
      expect(bank_account.balance).to eq 2000
    end

    it 'creates a transaction with date: 31/01/2022, credit: 1000, balance: 2000' do
      fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')
      bank_account.add_to_balance(1000, fakedate)
      expect(bank_account.transactions).to include({ date: '31/01/2022', credit: 1000, balance: 2000 })
    end
  end

  describe '#remove_from_balance' do
    it 'deducts 500 from the balance' do
      fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')
      bank_account.remove_from_balance(500, fakedate)
      expect(bank_account.balance).to eq 500
    end

    it 'creates a transaction with date, debit amount and balance' do
      fakedate = Date.new(2022, 1, 30).strftime('%d/%m/%Y')
      bank_account.remove_from_balance(200, fakedate)
      expect(bank_account.transactions).to include({ date: '30/01/2022', debit: 200, balance: 800 })
    end

    context 'it allows a pre-set overdraft'
    it 'deducts 1500 from balance of 1000' do
      fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')
      bank_account.remove_from_balance(1500, fakedate)
      expect(bank_account.balance).to eq(-500)
    end

    it 'raise error when trying to deduct more than overdraft limit, balance is 1000' do
      error_message = 'Denied! You cannot withdraw more than your overdraft limit!'
      fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')
      bank_account.remove_from_balance(1000, fakedate)
      expect { bank_account.remove_from_balance(600, fakedate) }.to raise_error error_message
    end
  end
end
