require_relative "boot"
require_relative "hacker"

class Bank
  @var1 = 1
  @var2 = 2
  @var3 = 3

  def run_transactions
    DB.clear
    Car.new(make: "Porsche", model: "911").save
    Car.new(make: "Nissan", model: "Skyline").save
    puts ap Car.all
  end
end
Bank.new.run_transactions
Hacker.new.hack1

# Build a simple bank
## Restrictions: The bank has a shitty server that can only store up to 3 variables. You can't nest classes within Bank, but have as many in the models folder as you like. However, the Hacker has access to the models folder too.

## Step 1

### The bank can put money into a users account

## 2: A Hacker appears
# Hacker.new.hack2
### Protect the user interface

## Step 3

### The bank can take money out of a users account
### The users account cannot go below 0, unless overdraft is set

## Step 4

### Store a Transaction History

## 5: A hacker appears
 Hacker.new.hack3
### Encrypt the database
# https://github.com/mdp/gibberish




