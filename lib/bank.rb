require_relative 'bank_account'

class Bank
  attr_reader :account

  def initialize(bank_account)
    @account = bank_account
  end

  def make_deposit(amount_deposit, date = Time.new.strftime('%d/%m/%Y'))
    @account.add_to_balance(amount_deposit, date)
  end

  def withdraw_money(amount, date = Time.new.strftime('%d/%m/%Y'))
    @account.remove_from_balance(amount, date)
  rescue StandardError => e
    puts e.message
  end

  def print_statement
    print_header
    @account.transactions.reverse.each do |transaction|
      credit = transaction[:credit].nil? ? ' ' : " #{format('%.2f', transaction[:credit])} "
      debit = transaction[:debit].nil? ? ' ' : " #{format('%.2f', transaction[:debit])} "
      puts "#{transaction[:date]} ||" + credit + '||' + debit + '||' + " #{format('%.2f', transaction[:balance])}"
    end
  end

  private

  def print_header
    puts 'date || credit || debit || balance'
  end
end
