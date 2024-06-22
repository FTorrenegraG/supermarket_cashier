# The Checkout class handles the process of scanning products and calculating the total price.
class Checkout
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items = Hash.new(0)
  end

  def scan(product)
    @items[product] += 1
  end

  def total
    base_total = @pricing_rules.base_total(@items)
    @pricing_rules.apply(@items, base_total).round(2)
  end
end
