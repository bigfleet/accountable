require 'spec_helper'

describe DetailAccount do

  subject { build(:detail_account) }

  it { should be_valid }
	
end

describe SummaryAccount do

  subject { build(:summary_account) }

  it { should be_valid }
	
end