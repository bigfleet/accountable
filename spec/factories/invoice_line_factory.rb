FactoryGirl.define do

  factory :invoice_line do
    invoice
    line_item :factory => :debit
    after_build do |invoice_line, evaluator|
      invoice_line.line_item.detail_account = invoice_line.invoice.buyer_account
    end
  end
  
end