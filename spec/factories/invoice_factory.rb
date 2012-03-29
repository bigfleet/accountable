FactoryGirl.define do

  factory :invoice do
  	buyer_account :factory => :detail_account
  	seller_account :factory => :detail_account
  	closed false
  end
  
end