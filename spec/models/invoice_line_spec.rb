require 'spec_helper'

describe InvoiceLine do

  subject { build(:invoice_line) }

  it { should be_valid }

  let(:invoice_line) { build(:invoice_line) }

  describe "validations" do

    it "should require association with an invoice" do
      invoice_line.invoice = nil
      invoice_line.should_not be_valid
    end

    it "should require association with transaction entry" do
      invoice_line.line_item = nil
      invoice_line.should_not be_valid
    end

    it "should require association with an open invoice" do
      invoice = create(:invoice, :closed => true)
      build(:invoice_line, :invoice => invoice).should_not be_valid
    end

    it "should require the line item source to be identical to the invoice recipient" do
      invoice_line.line_item.detail_account = create(:detail_account)
      invoice_line.should_not be_valid
    end

  end
	
end