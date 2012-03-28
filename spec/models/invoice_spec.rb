require 'spec_helper'

describe Invoice do

  subject { build(:invoice) }

  it { should be_valid }
	
end