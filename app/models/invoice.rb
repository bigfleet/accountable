class Invoice < ActiveRecord::Base
  belongs_to :buyer_account, :class_name => 'DetailAccount'
  belongs_to :seller_account, :class_name => 'DetailAccount'
  has_many :invoice_payments, :as => :auxilliary_model
  has_many :invoice_lines
  has_many :line_items, :through => :invoice_lines

  validates_presence_of :buyer_account, :seller_account

  def self.build(entries)
    accounts = check_accounts entries
    invoice = Invoice.create! :buyer_account => accounts[:buyer],
                              :seller_account => accounts[:seller]
    entries.each do |entry|
      line = invoice.invoice_lines.create :line_item => entry
      line.save!
    end
    invoice.close
    invoice
  end

  def close
    update_attribute(:closed, true)
  end

  def open?
    !closed?
  end

  def paid?
    amount_owed <= 0
  end

  def amount_billed
    line_items.inject(0) {|amount, item| amount + item.amount}
  end

  def amount_paid
    invoice_payments(true).inject(0) {|amount, payment| amount + payment.amount}
  end

  def amount_owed
    amount_billed - amount_paid
  end

  def pay_in_full(options = {})
    pay(amount_owed, options)
  end

  def pay(amount, options = {})
    options.merge!({:description => "Payment for Invoice ##{formatted_id}",
                    :auxilliary_model => self,
                    :account_from => buyer_account,
                    :account_to => seller_account,
                    :amount => amount})
    InvoicePayment.create! options
  end

  def formatted_id
    "%08i" % id
  end

private
  def self.check_accounts(entries)
    accounts, last_accounts = {}, {}
    entries.each do |entry|
      accounts = get_accounts entry
      raise ArgumentError, "All entries must involve the same accounts" unless
        last_accounts.empty? || accounts == last_accounts
      last_accounts = accounts
    end
    accounts
  end

  def self.get_accounts(entry)
    buyer = entry.detail_account
    seller = entry.accountable_transaction.debited_account
    seller = entry.accountable_transaction.credited_account if seller == buyer
    {:seller => seller, :buyer => buyer}
  end

end
