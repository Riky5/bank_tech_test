require_relative 'bank_account'

class Bank
  attr_reader :account

  def initialize(bank_account)
    @account = bank_account
  end

  # moved ---> date = Time.new.strftime('%d/%m/%Y') <--- in this class only for tests purposes.
  # originally it was in BankAccount class and it worked well.
  # Because of testing 'today s date' in feature spec I had to move it here.

  def make_deposit(amount_deposit, date = Time.new.strftime('%d/%m/%Y'))
    @account.add_to_balance(amount_deposit, date)
    puts "Successfully deposited #{amount_deposit}"
  end

  def withdraw_money(amount, date = Time.new.strftime('%d/%m/%Y'))
    @account.remove_from_balance(amount, date)
    puts "Successfully withdrawed #{amount}"
  end

  def print_statement
    puts 'date       ||' + 'credit'.rjust(10) + ' ||' + 'debit'.rjust(10) + ' ||' + 'balance'.rjust(10)
    @account.transactions.reverse.each do |transaction|
      puts "#{
              transaction[:date]} ||" + "#{format('%.2f',
              transaction[:credit]).to_s.rjust(10)} ||" + "#{format('%.2f',
              transaction[:debit]).to_s.rjust(10)} ||" + format('%.2f',
              transaction[:balance]).to_s.rjust(10).to_s
    end
  end
end
