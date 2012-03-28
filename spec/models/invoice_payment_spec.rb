require 'spec_helper'

describe InvoicePayment do

  subject { build(:invoice_payment) }

  it { should be_valid }
	
end