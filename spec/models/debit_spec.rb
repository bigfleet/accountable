require 'spec_helper'

describe Accountable::Debit do

  subject { build(:debit) }

  it { should be_valid }
	
end