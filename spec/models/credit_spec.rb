require 'spec_helper'

describe Credit do

  subject { build(:credit) }

  it { should be_valid }


  let(:credit){ build(:credit) }

  describe "validations" do

    it "should not permit negative credits" do
      credit.amount = -11.00
      credit.should_not be_valid
    end

    it "must require an accompanying debit" do
      lambda {
        credit.accountable_transaction.debit = nil
      }.should raise_error(ActiveRecord::RecordNotSaved)
    end

    it "must required accompanying a debit of identical amount" do
      credit.accountable_transaction.debit.amount = -20.00
      credit.should_not be_valid
    end

    it "must require an encompassing transaction" do
      credit.accountable_transaction = nil
      credit.should_not be_valid
    end

    it "must require an associated detail account" do
      credit.detail_account = nil
      credit.should_not be_valid
    end
  end

end