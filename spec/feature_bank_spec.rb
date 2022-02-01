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

    expect { bank.withdraw_money(3000) }.to output(<<~OUTPUT
      Successfully withdrawed 3000
    OUTPUT
                                                  ).to_stdout

    # uses overdraft limit when withdrawing
    expect { bank.withdraw_money(2100) }.to output(<<~OUTPUT
      Successfully withdrawed 2100
    OUTPUT
                                                  ).to_stdout

    expect { bank.print_statement }.to output(<<~OUTPUT
      date       ||    credit ||     debit ||   balance
      01/02/2022 ||      0.00 ||   2100.00 ||   -100.00
      01/02/2022 ||      0.00 ||   3000.00 ||   2000.00
      31/01/2022 ||   5000.00 ||      0.00 ||   5000.00
    OUTPUT
                                             ).to_stdout
  end
end
