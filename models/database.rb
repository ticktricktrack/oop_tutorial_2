class Database
  attr_reader :db
  def initialize
    @db = JsonStore.new("db.json")
    @db.pull
  end

  def all(model)
    results = db.get(model) || []
    results.map { |o| klass(model).new(o) }
  end

  # def find(model, attribute, query )
    # all(model).detect{ |o| o[attribute] == query }
  # end

  def store(model, object)
    with_new = all(model).push(object).uniq.map(&:to_hash)
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

module Persistence
  module ClassMethods
    def all
      DB.all(name)
    end

    def find(search_string)

    end
  end

  module InstanceMethods

    def initialize(args = {})
      args.each { |k,v| instance_variable_set("@#{k}", v) }
    end


    def save
      DB.store(self.class.name, self)
    end

    def to_hash
      Hash[keys.map { |k| [k, instance_variable_get("@" + k.to_s)] } ]
    end

    def keys
      self.class::ATTRS
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
