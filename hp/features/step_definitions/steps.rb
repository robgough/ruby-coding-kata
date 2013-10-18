Given(/^I buy (\d+) book$/) do |arg1|
  @point_of_sale = PointOfSale.new([1])  
end

When(/^I calculate the price$/) do
  @point_of_sale.calculate_price
end

Then(/^the price is (\d+) pounds$/) do |price|
  puts "POS price: #{@point_of_sale.price} and price: #{price}"
  expect(@point_of_sale.price).to eq(price.to_i)
end

Given(/^I buy (\d+) different books$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given(/^I buy (\d+) of the same books$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the price has a (\d+)% discount$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

class PointOfSale
  attr_reader :price
  def initialize(books)
    @book = books
  end
  def calculate_price
    @price = 8
  end
end
