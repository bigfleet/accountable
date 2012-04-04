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

    before(:each) do
      t = create(:transaction)
      buyer, seller = t.debited_account, t.credited_account
      t2 = buyer.transfer(14.99).to(seller, :description => "Second item")
      @i = Invoice.build([t.credit, t2.credit])
    end

    it "should calculate amount owed as a proper sum" do
      @i.amount_billed.should be_within(0.001).of(24.99)
    end

    it "should not be paid" do
      @i.should_not be_paid
    end

    it "should reflect no payments on creation" do
      @i.amount_paid.should be_within(0.001).of(0)
    end

    it "should indicate payment due in full" do
      @i.amount_billed.should == @i.amount_owed
    end

  end

  describe "paying" do

    before(:each) do
      t = create(:transaction)
      buyer, seller = t.debited_account, t.credited_account
      t2 = buyer.transfer(14.99).to(seller, :description => "Second item")
      @i = Invoice.build([t.credit, t2.credit])
    end

    describe "in full" do

      before(:each) do
        @i.pay_in_full
      end

      it "should not effect the amount billed" do
        @i.amount_billed.should be_within(0.001).of(24.99)
      end

      it "should indicate full payment" do
        @i.should be_paid
      end

      it "should calculate total payment" do
        @i.amount_paid.should be_within(0.001).of(24.99)
      end

      it "should indicate payment due in full" do
        @i.amount_owed.should be_within(0.001).of(0)
      end

    end

    describe "in part" do

      before(:each) do
        @i.pay(4.99)
        @i.pay(5.00)
      end

      it "should not effect the amount billed" do
        @i.amount_billed.should be_within(0.001).of(24.99)
      end

      it "should not indicate full payment" do
        @i.should_not be_paid
      end

      it "should calculate total payment" do
        @i.amount_paid.should be_within(0.001).of(9.99)
      end

      it "should indicate some payment due" do
        @i.amount_owed.should be_within(0.001).of(15.00)
      end


    end

  end

end