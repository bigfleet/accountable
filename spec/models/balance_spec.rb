require 'spec_helper'

describe Balance do

  subject { build(:balance) }

  it { should be_valid }

  let(:balance) { build(:balance) }

  describe "validations" do

    it "should require a linked account" do
      build(:balance, :account => nil).should_not be_valid
    end

  	it "should require an evaluation date" do
      build(:balance, :evaluated_at => nil).should_not be_valid
    end

  end

  describe "calculations" do

    it "should have an initial balance of 0" do
      balance = build(:balance, :balance => nil)
      balance.balance.should be_within(0.001).of(0)
    end

    it "should reflect a debit in the balance" do
      previous_balance = create(:balance, :evaluated_at => 1.day.ago)
      create(:accountable_transaction, :account_from => previous_balance.account)
      previous_balance.account.current_balance.balance.should be_within(0.001).of(90.0)
    end

    it "should reflect a credit in the balance" do
      previous_balance = create(:balance, :evaluated_at => 1.day.ago)
      create(:accountable_transaction, :account_to => previous_balance.account)
      previous_balance.account.current_balance.balance.should be_within(0.001).of(110.0)
    end

    it "should reflect multiple entries in the balance" do
      previous_balance = create(:balance, :evaluated_at => 1.day.ago)
      create(:accountable_transaction, :account_to => previous_balance.account, :amount => 17.00)
      create(:accountable_transaction, :account_from => previous_balance.account, :amount => 29.82)
      previous_balance.account.current_balance.balance.should be_within(0.001).of(87.18)
    end

  end

  it "should be read-only after persistance" do
    create(:balance).should be_readonly
  end

end