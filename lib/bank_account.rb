class BankAccount

  def initialize
    @balance = 0
  end

  def get_balance
    @balance
  end

  def add_to_balance(amount)
    @balance += amount
  end
end