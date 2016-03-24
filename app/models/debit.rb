class Debit < Entry
  validate :sign_convention
  has_one :credit, :through => :accountable_transaction

  def sign_convention
    errors.add(:base, "Debit must be non-positive") unless amount <= 0
  end

  def balanced?
    !credit.nil? and (credit.amount + amount == 0)
  end

end
