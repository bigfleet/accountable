class Transaction < ActiveRecord::Base
  has_one :debit
  has_one :credit
  has_one :credited_account, :through => :credit, :source => :detail_account
  has_one :debited_account, :through => :debit, :source => :detail_account
  belongs_to :auxilliary_model, :polymorphic => true

  validates_presence_of :description, :account_from, :account_to, :amount
  validate :sufficient_funds, :if => :require_funds?

  attr_accessor :account_from, :account_to, :amount

  def self.belongs_to_auxilliary_model(model)
    klass = model.to_s.classify
    belongs_to klass.underscore.to_sym, :foreign_key => :auxilliary_model_id
  end

  def self.required_auxilliary_model(model)
    belongs_to_auxilliary_model(model)
    validates_presence_of model.to_s.classify.underscore.to_sym
  end

  def completed?
    !debit.nil? and !credit.nil?
  end

  def amount
    completed? ? credit.amount : (@amount or 0)
  end

  def account_from
    completed? ? debit.detail_account : @account_from
  end

  def account_to
    completed? ? credit.detail_account : @account_to
  end

  def transaction_date
    super or created_at
  end

  def readonly?
    !new_record?
  end

private
  def create
    # Saving of debit, credit, and transaction should be done in one
    # atomic commit (the following block is an *SQL* transaction, not related
    # to our Transaction model)
    transaction do
      super
      create_debit :amount => -amount, :detail_account => account_from
      create_credit :amount => amount, :detail_account => account_to
    end
    completed?
  end

  def sufficient_funds
    sufficient = account_from && account_from.current_balance >= amount
    errors.add :base, "Insufficient funds in debit account" unless sufficient
  end
end
