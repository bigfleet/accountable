class Credit < Entry

  validate :require_debit
  validate :sign_convention
  validate :conservation_principle

  def sign_convention
    errors.add_to_base("Credit must be non-negative") unless amount >= 0
  end

  def debit
    transaction ? transaction.debit : nil
  end

  def require_debit
    errors.add_to_base("Debit must be saved before credit") unless !debit.nil?
  end

  def conservation_principle
    errors.add_to_base("Credit and debit amounts must add up to zero") unless
      (debit.nil? or amount + debit.amount == 0)
  end
end
