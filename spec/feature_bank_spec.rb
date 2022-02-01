require 'bank_account'
require 'bank'

describe 'Bank functionalities' do
  it 'sets bank account with overdraft limit of 100' do
    # bank account with 100 overdraft limit
    bank_account = BankAccount.new(100)

    bank = Bank.new(bank_account)

    fakedate = Date.new(2022, 1, 31).strftime('%d/%m/%Y')

    expect { bank.make_deposit(5000, fakedate) }.to output(<<~OUTPUT
      Successfully deposited 5000
    OUTPUT
                                                          ).to_stdout

    expect { bank.withdraw_money(3000, fakedate) }.to output(<<~OUTPUT
      Successfully withdrawed 3000
    OUTPUT
                                                            ).to_stdout

    # uses overdraft limit when withdrawing
    expect { bank.withdraw_money(2100, fakedate) }.to output(<<~OUTPUT
      Successfully withdrawed 2100
    OUTPUT
                                                            ).to_stdout

    expect { bank.withdraw_money(500, fakedate) }.to output(<<~OUTPUT
      Denied! You cannot withdraw more than your overdraft limit!
    OUTPUT
                                                            ).to_stdout

    expect { bank.print_statement }.to output(<<~OUTPUT
      date       ||    credit ||     debit ||   balance
      31/01/2022 ||      0.00 ||   2100.00 ||   -100.00
      31/01/2022 ||      0.00 ||   3000.00 ||   2000.00
      31/01/2022 ||   5000.00 ||      0.00 ||   5000.00
    OUTPUT
                                             ).to_stdout
  end

    it 'sets bank account with default overdraft limit of 0' do
    # bank account with 100 overdraft limit
    bank_account = BankAccount.new

    bank = Bank.new(bank_account)

    fakedate = Date.new(2022, 1, 25).strftime('%d/%m/%Y')

    expect { bank.make_deposit(8000, fakedate) }.to output(<<~OUTPUT
      Successfully deposited 8000
    OUTPUT
                                                          ).to_stdout

    expect { bank.withdraw_money(5000, fakedate) }.to output(<<~OUTPUT
      Successfully withdrawed 5000
    OUTPUT
                                                            ).to_stdout

    # uses overdraft limit when withdrawing
    expect { bank.withdraw_money(3000, fakedate) }.to output(<<~OUTPUT
      Successfully withdrawed 3000
    OUTPUT
                                                            ).to_stdout

    expect { bank.withdraw_money(100, fakedate) }.to output(<<~OUTPUT
      Denied! You cannot withdraw more than your overdraft limit!
    OUTPUT
                                                            ).to_stdout      

    expect { bank.print_statement }.to output(<<~OUTPUT
      date       ||    credit ||     debit ||   balance
      25/01/2022 ||      0.00 ||   3000.00 ||      0.00
      25/01/2022 ||      0.00 ||   5000.00 ||   3000.00
      25/01/2022 ||   8000.00 ||      0.00 ||   8000.00
    OUTPUT
                                             ).to_stdout
  end
end
