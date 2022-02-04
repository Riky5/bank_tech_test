require 'bank'

describe Bank do
  let(:bank) { Bank.new(bank_account) }
  let(:bank_account) { double('bank_account') }

  describe '#make_deposit' do
    it 'adds 1000 into bank account' do
      fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')
      allow(bank_account).to receive(:add_to_balance).with(1000, fakedate)
      bank.make_deposit(1000, fakedate)
      expect(bank_account).to have_received(:add_to_balance)
    end
  end

  describe '#withdraw_money' do
    it 'removes 500 from bank account assuming it has a balance of 1000' do
      fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')
      allow(bank_account).to receive(:remove_from_balance).with(500, fakedate)
      bank.withdraw_money(500, fakedate)
      expect(bank_account).to have_received(:remove_from_balance)
    end
  end

  describe '#print_statement' do
    context 'prints all transactions with details'
    it 'returns credit and debit transactions' do
      transactions = [
        { date: '10/01/2023', credit: 1000, balance: 1000 },
        { date: '13/01/2023', credit: 2000, balance: 3000 },
        { date: '14/01/2023', debit: 500, balance: 2500 }
      ]
      allow(bank_account).to receive(:transactions).and_return(transactions)

      expect { bank.print_statement }.to output(<<~OUTPUT
        date || credit || debit || balance
        14/01/2023 || || 500.00 || 2500.00
        13/01/2023 || 2000.00 || || 3000.00
        10/01/2023 || 1000.00 || || 1000.00
      OUTPUT
                                               ).to_stdout
    end
  end
end
