require_relative 'bank_account'

class Bank
  attr_reader :account

  def initialize(bank_account)
    @account = bank_account
  end

  def make_deposit(amount_deposit)
    @account.add_to_balance(amount_deposit)
  end
end
