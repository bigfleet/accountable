class InvoicePayment < Transaction
  validate :valid_invoice

  alias :invoice :auxilliary_model

  def pays_in_full?
    amount >= invoice.amount_billed
  end

private
  def valid_invoice
    invoice.is_a? Invoice
  end

end
