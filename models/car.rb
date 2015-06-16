class Car
  include Persistence

  ATTRS = [:make, :model]
  attr_accessor *ATTRS
end
