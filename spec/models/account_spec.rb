require 'spec_helper'

describe DetailAccount do

  subject { build(:detail_account) }

  it { should be_valid }

  let(:detail_account){ create(:detail_account) }

  describe "calculating current balances" do
  	it "should have an valid balance of 0 to start" do
      balance = detail_account.current_balance
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should == 0.0
  	end

    it "should be decremented with a debit" do
      detail_account.transfer(10.00).to(create(:detail_account), :description => "Test transfer")
      balance = detail_account.current_balance
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should be_within(0.0001).of(-10.00)
    end

    it "should be incremented with a debit" do
      target = create(:detail_account)
      detail_account.transfer(10.00).to(target, :description => "Test transfer")
      balance = target.current_balance
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should be_within(0.0001).of(10.00)
    end

    describe "in the past" do

      before(:each) do
        @from = create(:detail_account)
        @to = create(:detail_account)
      end
    
      it "should be decremented with a debit" do
       detail_account.transfer(10.00).to(create(:detail_account), :description => "Test transfer",
                                                                  :created_at => 1.week.ago)
       balance = detail_account.balance_at(1.day.ago)
       balance.should_not be_nil
       balance.should be_valid
       balance.balance.should be_within(0.0001).of(-10.00)
      end

      it "should be incremented with a debit" do
        target = create(:detail_account)
        detail_account.transfer(10.00).to(target, :description => "Test transfer", :created_at => 1.week.ago)
        balance = target.balance_at(1.day.ago)
        balance.should_not be_nil
        balance.should be_valid
        balance.balance.should be_within(0.0001).of(10.00)
      end

      it "should ignore transactions outside date range" do
        target = create(:detail_account)
        detail_account.transfer(10.00).to(target, :description => "Test transfer")
        balance = target.balance_at(1.day.ago)
        balance.should_not be_nil
        balance.should be_valid
        balance.balance.should be_within(0.0001).of(0.00)
      end

    end

    describe "finding previous balances" do

      it "should find the most recent balance before a given date" do
        day_b4 = create(:balance, :account => detail_account, :evaluated_at => 2.days.ago)
        yesterday = create(:balance, :account => detail_account, :evaluated_at => 1.day.ago)
        detail_account.balance_before(Date.today).should == yesterday
      end
    end

  end
	
end

describe SummaryAccount do

  subject { build(:summary_account) }

  it { should be_valid }
	
end