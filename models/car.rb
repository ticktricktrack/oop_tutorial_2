class Car
  include Persistence

  ATTRS = [:make, :model]
  attr_accessor *ATTRS

  def initialize(args = {})
    args.each { |k,v| instance_variable_set("@#{k}", v) }
  end
end
