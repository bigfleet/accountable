require 'spec_helper'

describe Accountable::Balance do

  subject { build(:balance) }

  it { should be_valid }
	
end