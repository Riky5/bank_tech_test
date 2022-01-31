class BankAccount
  def initialize
    @balance = 0
  end

  def read_balance
    @balance
  end

  def add_to_balance(amount)
    @balance += amount
  end

  def remove_from_balance(amount)
    @balance -= amount
  end
end
