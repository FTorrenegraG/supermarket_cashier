# The PricingRules class handles flexible pricing rules for the checkout system.
class PricingRules
  def initialize
    @rules = []
  end

  def add_rule(&rule)
    @rules << rule
  end

  def apply(items, base_total)
    @rules.each do |rule|
      base_total = rule.call(items, base_total)
    end
    base_total
  end

  def base_total(items)
    total = 0
    items.each do |product, quantity|
      total += product.price * quantity
    end
    total
  end
end
