require 'spec_helper'

describe Accountable::Credit do

  subject { build(:credit) }

  it { should be_valid }
	
end