require 'spec_helper'

describe Statement do
  
  before(:each) do
  	@account = create(:detail_account)
  	@statement = Statement.new(@account, 1.month.ago, Time.now)
  end

  it "should properly handle opening balance" do
  	@statement.start_balance.should be_within(0.001).of(0)
  end

  it "should properly ignore subsequent entries for opening balance" do
  	lambda{
      @account.transfer(10.00).to(create(:detail_account), :description => "Transfer")
    }.should_not change(@statement, :start_balance)
  end

  it "should properly handle no account activity" do
    @statement.end_balance.should be_within(0.001).of(0)
  end

  it "should properly incorporate subsequent entries for closing balance" do
    lambda{
      @account.transfer(10.00).to(create(:detail_account), :description => "Transfer",
                                                           :created_at => 2.days.ago)
    }.should change(@statement, :end_balance)
  end

  it "should properly discard entries before start date" do
    @account.transfer(10.00).to(create(:detail_account), :description => "Transfer",
                                                         :created_at => 2.months.ago)
    @statement.start_balance.should == @statement.end_balance
  end

  it "should properly discard entries after end date" do
    @account.transfer(10.00).to(create(:detail_account), :description => "Transfer",
                                                         :created_at => 1.month.from_now)
    @statement.start_balance.should == @statement.end_balance
  end

end