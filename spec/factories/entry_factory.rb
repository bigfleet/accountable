FactoryGirl.define do

  factory :credit, :class => "Accountable::Credit" do
  end
  
  factory :debit, :class => "Accountable::Debit" do
  end

end