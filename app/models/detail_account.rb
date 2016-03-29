class DetailAccount < Account
  has_many :entries
  has_many :accountable_transactions, :through => :entries
  has_many :debits
  has_many :credits

  def transfer(amount)
    BlankTransaction.new amount, self
  end

end
