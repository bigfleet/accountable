require 'spec_helper'

describe Credit do

  subject { build(:credit) }

  it { should be_valid }

  let(:credit){ build(:credit) }
	
end