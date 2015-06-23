class User
  include Persistence

  ATTRS = [:name, :balance, :overdraft]
  attr_accessor *ATTRS

  def save
    return false if @password != ENV["USER_SECRET"]
    super
  end
  
  def deposit(amount)
    @balance += amount
    log_transaction("deposit", amount) if save
  end

  def withdraw(amount)
    return false if over_limit?(amount)
    @balance -= amount
    log_transaction("withdraw", amount) if save
  end

  def over_limit?(amount)
    balance - amount < 0 - overdraft
  end

  def overdraft
    @overdraft ||= 0
  end

  private

  def log_transaction(action, amount)
    Transaction.new(name: Time.now.to_f, customer: name, action: action, amount: amount).save
  end

end