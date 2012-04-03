require 'spec_helper'

describe DetailAccount do

  subject { build(:detail_account) }

  it { should be_valid }

  let(:detail_account){ create(:detail_account) }

  describe "calculating balances" do
  	it "should have an valid balance of 0 to start" do
      balance = detail_account.balance_at(Date.today)
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should == 0.0
  	end

    it "should be decremented with a debit" do
      detail_account.transfer(10.00).to(create(:detail_account), :description => "Test transfer")
      balance = detail_account.balance_at(Time.now)
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should be_within(0.0001).of(-10.00)
    end

    it "should be incremented with a debit" do
      target = create(:detail_account)
      detail_account.transfer(10.00).to(target, :description => "Test transfer")
      balance = target.balance_at(Time.now)
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should be_within(0.0001).of(10.00)
    end

  end
	
end

describe SummaryAccount do

  subject { build(:summary_account) }

  it { should be_valid }
	
end