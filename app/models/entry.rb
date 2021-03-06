class Entry < ActiveRecord::Base

  belongs_to :detail_account
  belongs_to :transaction
  has_one :invoice_line, :as => :line_item
  validates_presence_of :detail_account, :transaction
  validates_numericality_of :amount

  def readonly?
    !new_record?
  end

end
