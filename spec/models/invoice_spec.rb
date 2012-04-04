require 'spec_helper'

describe Invoice do

  subject { build(:invoice) }

  it { should be_valid }

  let(:invoice){ build(:invoice) }

  describe "validations" do
    it "must be associated with a buyer" do
      invoice.buyer_account = nil
      invoice.should_not be_valid
    end

    it "must be associated with a seller" do
      invoice.seller_account = nil
      invoice.should_not be_valid
    end
  end

  describe "building" do

    it "should be able to build an invoice successfully" do
      lambda{ 
        c = create(:credit)
        i = Invoice.build([c]) 
        i.line_items.should have(1).things
        i.line_items.first.should == c
        i.buyer_account.should == c.detail_account
        i.seller_account.should == c.transaction.debit.detail_account
        i.should be_closed
      }.should change(Invoice, :count).by(1)
    end

    it "should not allow line items from different accounts to be placed in an invoice" do
      lambda{
        Invoice.build([create(:credit), create(:credit)])
      }.should raise_error(ArgumentError)
    end

  end

  describe "net and payment calculations" do
  end

  describe "paying" do
  end

end