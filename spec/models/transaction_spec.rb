require 'spec_helper'

describe Transaction do

  subject { build(:transaction) }

  it { should be_valid }
	
end