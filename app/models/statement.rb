class Statement
  attr_accessor :account, :period_start, :period_end

  def initialize(account, period_start, period_end)
    @account = account
    @period_start = period_start
    @period_end = period_end
  end

  def entries
    account.entries.where(entry_conditions).
                    joins(:accountable_transaction).
                    order("created_at ASC")
  end

  def start_balance
    account.balance_at(period_start).balance
  end

  def end_balance
    account.balance_at(period_end).balance
  end

private
  def entry_conditions
    column = "accountable_transactions.created_at"
    ["#{column} > ? AND #{column} <= ?", period_start, period_end]
  end

end
