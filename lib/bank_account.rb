class BankAccount

  attr_reader :transactions

  def initialize
    @balance = 0
    @transactions = []
  end

  def read_balance
    @balance
  end

  def add_to_balance(credit, today = Time.new.strftime('%d/%m/%Y'))
    @balance += credit
    @transactions << { :date => "#{today}", :credit => "#{credit}.00".to_i, :debit => 0, :balance => read_balance }
  end

  def remove_from_balance(debit, today = Time.new.strftime('%d/%m/%Y'))
    @balance -= debit
    @transactions << { :date => "#{today}", :credit => 0, :debit => "#{debit}.00".to_i, :balance => read_balance }
  end
end
