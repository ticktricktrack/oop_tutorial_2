class User
  include Persistence

  ATTRS = [:name, :balance]
  attr_accessor *ATTRS

  def save
    return false if @password != "qwerty"
    super
  end
  
  def deposit(amount)
    @balance += amount
    save
  end

end