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
  end

  describe "net and payment calculations" do
  end

  describe "paying" do
  end

end