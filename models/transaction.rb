class Transaction
  include Persistence

  ATTRS = [:name, :customer, :action, :amount]
  attr_accessor *ATTRS



end
