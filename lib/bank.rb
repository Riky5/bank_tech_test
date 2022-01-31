require_relative 'bank_account'

class Bank
  attr_reader :account

  def initialize(bank_account)
    @account = bank_account
  end

  def make_deposit(amount_deposit)
    @account.add_to_balance(amount_deposit)
  end

  def withdraw_money(amount)
    @account.remove_from_balance(amount)
  end

  def print_statement
    puts "date       || credit  ||  debit  || balance"
    @account.transactions.reverse.each do |transaction|
      puts "#{transaction[:date]} ||" + "#{sprintf("%.2f",transaction[:credit]).to_s.rjust(8)} ||" + "#{sprintf("%.2f",transaction[:debit]).to_s.rjust(8)} ||" + " #{sprintf("%.2f",transaction[:balance])}"
    end
  end
end
