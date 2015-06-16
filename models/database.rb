class Database
  attr_reader :db
  def initialize
    @db = JsonStore.new("db.json")
    @db.pull
  end

  def all(model)
    db.get(model) || []
  end

  def find(model, attribute, query )
    all(model).detect{ |o| o[attribute] == query }
  end

  def store(model, object)
    with_new = all(model).push(object).uniq
    db.set(model, with_new)
    db.merge
    db.push
  end

  def klass(symbol)
    symbol.to_s.capitalize.constantize
  end

  def clear
    db.clear
    db.push
  end

end

module UseDatabase
  module ClassMethods
    def all
      DB.all(name)
    end

    def find(search_string)

    end
  end
  
  module InstanceMethods
    def save
      DB.store(self.class.name, self)
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end