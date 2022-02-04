require 'bank_account'
require 'bank'

describe 'Bank functionalities' do
  it 'sets bank account with overdraft limit of 100' do
    # bank account with 100 overdraft limit
    bank_account = BankAccount.new(100)

    bank = Bank.new(bank_account)

    fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')

    bank.make_deposit(5000, fakedate)
    bank.withdraw_money(3000, fakedate)
    # uses overdraft limit when withdrawing
    bank.withdraw_money(2100, fakedate)

    expect { bank.withdraw_money(500, fakedate) }.to output(<<~OUTPUT
      Denied! You cannot withdraw more than your overdraft limit!
    OUTPUT
                                                           ).to_stdout
    print bank_account.transactions
    expect { bank.print_statement }.to output(<<~OUTPUT
      date || credit || debit || balance
      31/01/2022 || || 2100.00 || -100.00
      31/01/2022 || || 3000.00 || 2000.00
      31/01/2022 || 5000.00 || || 5000.00
    OUTPUT
                                             ).to_stdout
  end

  it 'sets bank account with default overdraft limit of 0' do
    # bank account with 100 overdraft limit
    bank_account = BankAccount.new

    bank = Bank.new(bank_account)

    fakedate = Date.new(2022, 1, 25).strftime('%d/%m/%Y')

    bank.make_deposit(8000, fakedate)
    bank.withdraw_money(5000, fakedate)
    # uses overdraft limit when withdrawing
    bank.withdraw_money(3000, fakedate)

    expect { bank.withdraw_money(100, fakedate) }.to output(<<~OUTPUT
      Denied! You cannot withdraw more than your overdraft limit!
    OUTPUT
                                                           ).to_stdout

    expect { bank.print_statement }.to output(<<~OUTPUT
      date || credit || debit || balance
      25/01/2022 || || 3000.00 || 0.00
      25/01/2022 || || 5000.00 || 3000.00
      25/01/2022 || 8000.00 || || 8000.00
    OUTPUT
                                             ).to_stdout
  end
end
