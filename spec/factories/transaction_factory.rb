FactoryGirl.define do

  factory :accountable_transaction do |t|
    t.description "Test transaction"
    t.association :account_from, :factory => :detail_account
    t.association :account_to, :factory => :detail_account
    t.amount 10.00

    t.after_build do |transaction, evaluator|
      transaction.build_components
    end

    factory :invoice_payment do
      auxilliary_model :factory => :invoice
    end
  end

end