require 'spec_helper'

describe AccountableTransaction do

  subject { build(:accountable_transaction) }

  it { should be_valid }

  let(:accountable_transaction){ build(:accountable_transaction)}

  describe "validations" do

    it "should require a source account" do
      build(:accountable_transaction, :account_from => nil).should_not be_valid
    end

    it "should require a target account" do
      build(:accountable_transaction, :account_to => nil).should_not be_valid
    end

    it "should require a description" do
      build(:accountable_transaction, :description => nil).should_not be_valid
    end

    it 'should not allow a transaction in NSF conditions' do
      build(:accountable_transaction, :require_funds => true).should_not be_valid
    end

  end

  describe "recording" do

    it "should create a credit" do
      lambda{ accountable_transaction.save }.should change(Credit, :count).by(1)
    end

    it "should create a debit" do
      lambda{ accountable_transaction.save }.should change(Debit, :count).by(1)
    end

    it "should not be completed before it is committed" do
      accountable_transaction.should_not be_completed
      accountable_transaction.save
      accountable_transaction.should be_completed
    end

    it "should become read-only afterward" do
      accountable_transaction.save
      accountable_transaction.should be_readonly
    end

  end


end