require 'rspec'
require_relative '../../app/models/product'
require_relative '../../app/models/pricing_rules'
require_relative '../../app/models/checkout'

RSpec.describe Checkout do
  let(:green_tea) { Product.new('GR1', 'Green tea', 3.11) }
  let(:strawberries) { Product.new('SR1', 'Strawberries', 5.00) }
  let(:coffee) { Product.new('CF1', 'Coffee', 11.23) }
  let(:pricing_rules) { PricingRules.new }
  let(:checkout) { Checkout.new(pricing_rules) }

  before do
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
  end

  it 'calculates total for basket: GR1, SR1, GR1, GR1, CF1' do
    checkout.scan(green_tea)
    checkout.scan(strawberries)
    checkout.scan(green_tea)
    checkout.scan(green_tea)
    checkout.scan(coffee)
    expect(checkout.total).to eq(22.45)
  end

  it 'calculates total for basket: GR1, GR1' do
    checkout.scan(green_tea)
    checkout.scan(green_tea)
    expect(checkout.total).to eq(3.11)
  end

  it 'calculates total for basket: SR1, SR1, GR1, SR1' do
    checkout.scan(strawberries)
    checkout.scan(strawberries)
    checkout.scan(green_tea)
    checkout.scan(strawberries)
    expect(checkout.total).to eq(16.61)
  end

  it 'calculates total for basket: GR1, CF1, SR1, CF1, CF1' do
    checkout.scan(green_tea)
    checkout.scan(coffee)
    checkout.scan(strawberries)
    checkout.scan(coffee)
    checkout.scan(coffee)
    expect(checkout.total).to eq(30.57)
  end
end
