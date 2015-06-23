class Database
  attr_reader :db
  def initialize
    @db = JsonStore.new("db.json")
    @db.pull
  end

  def all(model)
    results = db.get(model) || []
    results = decrypt(results) if results.present?
    results.map { |o| klass(model).new(o) }
  end

  def store(model, object)
    with_new = all(model).reject { |o| o.name == object.name }

    with_new = with_new.push(object).uniq.map(&:to_hash)
    db.set(model, encrypt(with_new))
    db.merge
    db.push
    true
  end

  def klass(symbol)
    symbol.to_s.capitalize.constantize
  end

  def clear
    db.clear
    db.push
  end

  private

  def cipher
    Gibberish::AES.new(ENV["CIPHER_SECRET"])
  end

  def encrypt(obj)
    cipher.encrypt(Marshal.dump(obj))
  end

  def decrypt(encrypted)
    Marshal.load(cipher.decrypt(encrypted))
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

    def create
      save
      return self
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
