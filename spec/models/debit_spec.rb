require 'spec_helper'

describe Debit do

  subject { build(:debit) }

  it { should be_valid }

  let(:debit){ build(:debit) }  

  describe "validations" do

    it "should not permit positive debits" do
      debit.amount = 11.00
      debit.should_not be_valid
    end

    it "must require an accompanying credit" do
      lambda {
        debit.transaction.credit = nil
      }.should raise_error(ActiveRecord::RecordNotSaved)
    end

  end  

  it "should be balanced by default" do
    debit.should be_balanced
  end
	
end