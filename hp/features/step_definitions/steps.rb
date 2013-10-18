require_relative '../../lib/point_of_sale'
#
# Transforms all digits into numbers.
Transform /(\d+)/ do |number|
  number.to_i
end

Given(/^I buy a book$/) do
  add_to_basket [1]
end

When(/^I calculate the price$/) do
end

Then(/^the price is (\d+) pounds$/) do |price|
  expect(total_price).to eq(price)
end

Given(/^I buy (\d+) different books$/) do |q|
  a = *(1..q)
  add_to_basket a
end

Given(/^I buy (\d+) of the same books$/) do |q|
  a = *(1..q).inject([]) { |a, b| a << 1 }
  add_to_basket a 
end

Then(/^the price has a (\d+)% discount$/) do |discount|
  # take the discount and find out the multiplier.
  # e.g. discount = 10%
  # 100% -10%  = 90%
  # 90 / 100 = 0.9 = multiplier
  multiplier = ( 100 - discount ).to_f / 100
  expect(total_price).to eq((number_of_books*8)*multiplier)
end
