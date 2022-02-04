class BankAccount
  attr_reader :transactions, :balance

  def initialize(overdraft = 0)
    @balance = 0
    @transactions = []
    @overdraft_limit = overdraft
  end

  def add_to_balance(credit, date)
    @balance += credit
    @transactions << { date: date, credit: credit, balance: @balance }
  end

  def remove_from_balance(debit, date)
    check_overdraft(debit)
    @balance -= debit
    @transactions << { date: date, debit: debit, balance: @balance }
  end

  private

  def check_overdraft(debit)
    message = 'Denied! You cannot withdraw more than your overdraft limit!'
    raise message if debit > (@balance + @overdraft_limit)
  end
end
