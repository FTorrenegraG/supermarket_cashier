require_relative 'models/product'
require_relative 'models/pricing_rules'
require_relative 'models/checkout'

# Setting up products
green_tea = Product.new('GR1', 'Green tea', 3.11)
strawberries = Product.new('SR1', 'Strawberries', 5.00)
coffee = Product.new('CF1', 'Coffee', 11.23)

pricing_rules = PricingRules.new

# Rule: Buy one, get one free for green tea
pricing_rules.add_rule do |items, total|
  green_tea_count = items[green_tea]
  if green_tea_count
    free_items = green_tea_count / 2
    total -= free_items * green_tea.price
  end
  total
end

# Rule: Volume discount for strawberries
pricing_rules.add_rule do |items, total|
  strawberry_count = items[strawberries]
  total -= strawberry_count * (strawberries.price - 4.50) if strawberry_count && strawberry_count >= 3
  total
end

# Rule: Volume discount for coffee
pricing_rules.add_rule do |items, total|
  coffee_count = items[coffee]
  total -= coffee_count * (coffee.price - (coffee.price * 2 / 3)) if coffee_count && coffee_count >= 3
  total
end

# Example usage
checkout = Checkout.new(pricing_rules)
checkout.scan(green_tea)
checkout.scan(strawberries)
checkout.scan(green_tea)
checkout.scan(green_tea)
checkout.scan(coffee)
puts "Total: £#{checkout.total}"
