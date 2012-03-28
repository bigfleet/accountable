require 'spec_helper'

describe Accountable::Account do

  subject { build(:account) }

  it { should be_valid }
	
end