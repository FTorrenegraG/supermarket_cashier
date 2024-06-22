# Supermarket Cashier

This is a simple cashier system for a small chain of supermarkets. The system adds products to a cart and displays the total price, including special pricing rules.

## Table of Contents

- [Setup](#setup)
- [Usage](#usage)
- [Tests](#tests)
- [Pricing Rules](#pricing-rules)
- [Project Structure](#project-structure)

## Setup

1. Clone the repository:
  ```sh
  git clone https://github.com/FTorrenegraG/supermarket_cashier
  cd supermarket_cashier
  ```
2. Install dependencies:
  ```sh
  bundle install
  ```
## Usage

You can run the main script to see an example of how the system works.

1. Navigate to the `app` directory:
  ```sh
  cd app
  ```
2. Run the `main.rb` script:
  ```sh
  ruby main.rb
  ```
  This script sets up the products, applies the pricing rules, and simulates scanning items to calculate the total price. The expected output is:

  ```
  Total: £22.45
  ```
  
  Example of use:
  ```ruby
  checkout = Checkout.new(pricing_rules)
  checkout.scan(green_tea)
  checkout.scan(strawberries)
  checkout.scan(green_tea)
  checkout.scan(green_tea)
  checkout.scan(coffee)
  puts "Total: £#{checkout.total}"
  ```

## Tests

To run the tests, use RSpec. Ensure you are in the project root directory:

1. Run the tests:
  ```sh
  bundle exec rspec
  ```
  This will run all the tests in the spec directory and display the results.

## Pricing Rules

The following pricing rules are implemented in the system:

1. Buy one, get one free for green tea (GR1).
2. Volume discount for strawberries (SR1): If you buy 3 or more, the price drops to £4.50 each.
3. Volume discount for coffee (CF1): If you buy 3 or more, the price drops to two-thirds of the original price.

These rules can be found and modified in `app/main.rb`

## Project Structure

  ```
  supermarket_cashier/
  ├── app/
  │   ├── main.rb
  │   ├── models/
  │   │   ├── product.rb
  │   │   ├── pricing_rules.rb
  │   │   └── checkout.rb
  ├── spec/
  │   ├── models/
  │   │   └── checkout_spec.rb
  ├── .rubocop.yml
  ├── Gemfile
  ├── Gemfile.lock
  └── README.md
  ```
