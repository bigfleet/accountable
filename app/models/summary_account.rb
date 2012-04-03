class SummaryAccount < Account
  has_and_belongs_to_many :accounts, :join_table => :account_joins
  has_many :entries, :through => :accounts
  validate :no_recursion

private
  def no_recursion
    errors.add(:base, "Summary account cannot summarize itself") if
      accounts.include? self
  end
end
