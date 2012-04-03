require 'spec_helper'

describe BlankTransaction do

  let(:from){ create(:detail_account) }
  let(:to){ create(:detail_account) }

  it "should exhibit the expected signature for use" do
    lambda{ 
      from.transfer(10.00).to(to, :description => "Test transfer")
    }.should change(Transaction, :count).by(1)
  end

  it "should post the appropriate debit to the transfer source" do
    from.transfer(10.00).to(to, :description => "Test transfer")
    from.debits.should have(1).thing
    from.debits.first.amount.should == -10.00
  end

  it "should post the appropriate credit to the transfer recipient" do
    from.transfer(10.00).to(to, :description => "Test transfer")
    to.credits.should have(1).thing
    to.credits.first.amount.should == 10.00
  end
end