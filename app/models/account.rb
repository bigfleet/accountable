class Accountable::Account < ActiveRecord::Base 

	self.table_name = "accounts"

  has_many :balances

  class << self
    attr_accessor :owner_type
  end

  def self.owned_by(klass)
    @owner_type = klass.to_s.classify.constantize
    belongs_to :owner, :polymorphic => true
    validate :check_owner_type
  end

  def balance_at(date)
    balance = Balance.find_by_account_id_and_evaluated_at(id, date)
    balance ||= Balance.new(:account => self, :evaluated_at => date)
  end

  def balance_before(date)
    balances.find :first, :conditions => ["evaluated_at < ?", date],
                          :order => "evaluated_at DESC"
  end

  def current_balance
    balance_at(Time.now)
  end

private
  def check_owner_type
    errors.add_to_base "owner must be an #{self.class.owner_type}" if
      self.class.owner_type and !(owner.is_a? self.class.owner_type)
  end
	
end