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

  describe '#withdraw_money' do
    it 'removes 500 from bank account assuming it has a balance of 1000' do
      allow(bank_account).to receive(:add_to_balance).with(1000)
      allow(bank_account).to receive(:remove_from_balance).with(500)
      allow(bank_account).to receive(:read_balance).and_return(500)
      bank.withdraw_money(500)
      expect(bank.account.read_balance).to eq 500
    end
  end

  describe '#print_statement' do
    context 'prints all transactions with details'
    it 'returns credit and debit transactions' do
      transactions = [{ :date => '31/01/2022', :credit => sprintf("%.2f",1000.00), :debit => "0", :balance => sprintf("%.2f",1000.00) }, { :date => '31/01/2022', :credit => sprintf("%.2f",2000.00), :debit => "0", :balance => sprintf("%.2f",3000.00) }, { :date => '31/01/2022', :credit => "0", :debit => sprintf("%.2f",500.00), :balance => sprintf("%.2f",2500.00) }]
      allow(bank_account).to receive(:transactions).and_return(transactions)

      expect{ bank.print_statement }.to output(<<-output
date       || credit  ||  debit  || balance
31/01/2022 ||       0 ||  500.00 || 2500.00
31/01/2022 || 2000.00 ||       0 || 3000.00
31/01/2022 || 1000.00 ||       0 || 1000.00
            output
            ).to_stdout
    end  
  end
end
