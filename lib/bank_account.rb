class BankAccount
  attr_reader :transactions

  def initialize(overdraft = 0)
    @balance = 0
    @transactions = []
    @overdraft_limit = overdraft
  end

  def read_balance
    @balance
  end

  def add_to_balance(credit, date)
    @balance += credit
    @transactions << { date: date.to_s, credit: "#{credit}.00".to_i, debit: 0, balance: read_balance }
  end

  def remove_from_balance(debit, date)
    check_overdraft(debit)
    @balance -= debit
    @transactions << { date: date.to_s, credit: 0, debit: "#{debit}.00".to_i, balance: read_balance }
  end

  private

  def check_overdraft(debit)
    raise 'Denied! You cannot withdraw more than your overdraft limit!' if debit > (@balance + @overdraft_limit)
  end
end
