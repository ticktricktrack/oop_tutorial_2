require_relative "boot"

DB.clear

Car.new(make: "Porsche", model: "911").save

binding.pry
puts ap Car.all
