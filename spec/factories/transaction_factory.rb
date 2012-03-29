FactoryGirl.define do

  factory :invoice_payment do
  end

  factory :transaction do |t|
    t.description "Test transaction"
    t.association :account_from, :factory => :detail_account
    t.association :account_to, :factory => :detail_account
    t.amount 10.00
  end
  
end