require 'spec_helper'

describe AccountableTransaction do

  subject { build(:transaction) }

  it { should be_valid }

  let(:transaction){ build(:transaction)}

  describe "validations" do

    it "should require a source account" do
      build(:transaction, :account_from => nil).should_not be_valid
    end

    it "should require a target account" do
      build(:transaction, :account_to => nil).should_not be_valid
    end

    it "should require a description" do
      build(:transaction, :description => nil).should_not be_valid
    end

    it 'should not allow a transaction in NSF conditions' do
      build(:transaction, :require_funds => true).should_not be_valid
    end

  end

  describe "recording" do

    it "should create a credit" do
      lambda{ transaction.save }.should change(Credit, :count).by(1)
    end

    it "should create a debit" do
      lambda{ transaction.save }.should change(Debit, :count).by(1)
    end

    it "should not be completed before it is committed" do
      transaction.should_not be_completed
      transaction.save
      transaction.should be_completed
    end

    it "should become read-only afterward" do
      transaction.save
      transaction.should be_readonly
    end

  end


end