puts "Booting..."

require "active_support"
require "active_support/core_ext"
require "pry"
require "awesome_print"
require "json_store"
require "require_all"

require_all "models"
DB = Database.new

puts "Done"
