require 'spec_helper'

describe Accountable::Account do

  let(:account) { Factory(:account) }

  it "should return a valid account from the factory" do
    account.should be_valid
  end
	
end