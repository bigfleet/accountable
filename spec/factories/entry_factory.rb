FactoryGirl.define do

  factory :credit do |c|
  	c.association :transaction

    c.after_build do |credit, evaluator|
      credit.detail_account = credit.transaction.account_to
      credit.amount = credit.transaction.amount
    end
  end
  
  factory :debit do |d|
  	d.association :transaction
  	d.after_build do |debit, evaluator|
      debit.detail_account = debit.transaction.account_from
      debit.amount = (0 - debit.transaction.amount)
    end

  end

end