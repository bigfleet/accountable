require 'spec_helper'

describe DetailAccount do

  subject { build(:detail_account) }

  it { should be_valid }

  let(:detail_account){ build(:detail_account) }

  describe "calculating balances" do
  	it "should have an valid balance of 0 to start" do
      balance = detail_account.balance_at(Date.today)
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should == 0.0
  	end

    it "should be incremented with a credit" do
      detail_account.transfer(10.00).to(build(:detail_account), :description => "Test transfer")
      balance = detail_account.balance_at(Date.today)
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should == -10.00
    end

    it "should be decremented with a credit" do
      balance = detail_account.balance_at(Date.today)
      balance.should_not be_nil
      balance.should_not be_valid
    end
  end
	
end

describe SummaryAccount do

  subject { build(:summary_account) }

  it { should be_valid }
	
end