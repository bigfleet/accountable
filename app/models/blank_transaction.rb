class BlankTransaction
  attr_accessor :amount, :account_from

  def initialize(amount, account_from)
    @amount = amount
    @account_from = account_from
  end

  def to(account_to, args = {})
    Transaction.create(args.merge( 
                  :account_from => @account_from,
                 :account_to => account_to,
                 :amount => @amount ))
  end

end
