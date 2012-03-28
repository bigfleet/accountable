require 'spec_helper'

describe InvoiceLine do

  subject { build(:invoice_line) }

  it { should be_valid }
	
end