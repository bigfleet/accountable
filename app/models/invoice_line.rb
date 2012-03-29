class InvoiceLine < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :line_item, :class_name => 'Entry'
  validates_presence_of :invoice, :line_item
  validate :open_invoice
  validate :correct_account
  validates_uniqueness_of :line_item_id

  def paid?
    invoice.paid?
  end

private

  def open_invoice
    errors.add_to_invoice "is closed" unless invoice(true).open?
  end

  def correct_account
    errors.add(:base, "Line item is applied to the wrong account") unless
      line_item.detail_account == invoice.buyer_account
  end

end
