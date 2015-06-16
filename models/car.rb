Car = Struct.new(:make, :model) do
  def save
    DB.store(:car, self)
  end

  def self.all
    DB.all(:car)
  end

  def self.find(search_string)
    DB.find(:car, "model", search_string)
  end
end
