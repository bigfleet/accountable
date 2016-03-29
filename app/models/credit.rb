class Credit < Entry

  validate :require_debit
  validate :sign_convention
  validate :conservation_principle

  def sign_convention
    errors.add(:amount, "Credit must be non-negative") unless amount >= 0
  end

  def debit
    accountable_transaction ? accountable_transaction.debit : nil
  end

  def require_debit
    errors.add(:base, "Debit must be saved before credit") unless !debit.nil?
  end

  def conservation_principle
    errors.add(:base, "Credit and debit amounts must add up to zero") unless
      (debit.nil? or amount + debit.amount == 0)
  end
end
