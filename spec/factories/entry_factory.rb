FactoryGirl.define do

  factory :credit do |c|
  	c.association :accountable_transaction

    c.after_build do |credit, evaluator|
      credit.detail_account = credit.accountable_transaction.account_to
      credit.amount = credit.accountable_transaction.amount
      #credit.accountable_transaction.credit = credit
    end
  end

  factory :debit do |d|
  	d.association :accountable_transaction
  	d.after_build do |debit, evaluator|
      debit.detail_account = debit.accountable_transaction.account_from
      debit.amount = (0 - debit.accountable_transaction.amount)
      #debit.accountable_transaction.debit = debit
    end

  end

end