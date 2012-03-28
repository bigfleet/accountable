require 'spec_helper'

describe Account do

  subject { build(:account) }

  it { should be_valid }
	
end