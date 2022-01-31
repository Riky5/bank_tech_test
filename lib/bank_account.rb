class BankAccount

  attr_reader :transactions

  def initialize
    @balance = 0
    @transactions = []
  end

  def read_balance
    @balance
  end

  def add_to_balance(amount, today = Time.new.strftime('%d/%m/%Y'))
    @balance += amount
    @transactions << { :date => "#{today}", :credit => "#{amount}".to_i, :balance => read_balance }
  end

  def remove_from_balance(amount, today = Time.new.strftime('%d/%m/%Y'))
    @balance -= amount
    @transactions << { :date => "#{today}", :debit => "#{amount}".to_i, :balance => read_balance }
  end
end
