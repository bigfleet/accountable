require 'spec_helper'

describe "Account" do

  it "should find an account" do
    lambda{ Accountable::Account }.should_not raise_error
  end
	
end