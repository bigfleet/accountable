class Balance < ActiveRecord::Base

  belongs_to :account
  validates_presence_of :account, :evaluated_at, :balance

  def balance
    super or self.balance = calculate_balance
  end

  def readonly?
    !new_record?
  end

private

  def calculate_balance
    entries.inject(previous_balance) {|balance, entry| balance + entry.amount}
  end

  def previous
    account.balance_before(evaluated_at)
  end

  def previous_balance
    previous ? previous.balance : 0
  end

  def entries
    account.entries.where(entry_conditions).joins(:accountable_transaction).all
  end

  def entry_conditions
    column = "accountable_transactions.created_at"
    if previous
     ["#{column} > ? AND #{column} <= ?", previous.evaluated_at, evaluated_at]
    else
     ["#{column} <= ?", evaluated_at]
    end
  end

end
