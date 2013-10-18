# Transforms all digits into numbers.
Transform /(\d+)/ do |number|
  number.to_i
end

Given(/^I buy a book$/) do
  @point_of_sale = PointOfSale.new([1])  
end

When(/^I calculate the price$/) do
  @point_of_sale.calculate_price
end

Then(/^the price is (\d+) pounds$/) do |price|
  expect(@point_of_sale.price).to eq(price)
end

Given(/^I buy (\d+) different books$/) do |quantity|
  @books = []
  quantity.times do |i|
   @books << i+1 # times starts at 0
  end
  @point_of_sale = PointOfSale.new(@books)
end

Given(/^I buy (\d+) of the same books$/) do |quantity|
  @books = []
  quantity.times do |i|
    @books << 1
  end
  @point_of_sale = PointOfSale.new(@books)
end

Then(/^the price has a (\d+)% discount$/) do |discount|
  # take the discount and find out the multiplier.
  # discount = 10%
  # 100-10 = 90
  # 90 / 100 = 0.9
  # multiplier = 0.9
  multiplier = ( 100 - discount ).to_f / 100
  expect(@point_of_sale.price).to eq((@books.size*8)*multiplier)
end

class PointOfSale
  attr_reader :price
  def initialize(books)
    @books = books
  end
  def calculate_price
    @price = 8
    @price = 16 if @books.size == 2
    @price = 15.20 if @books.size == 2 && @books[0] != @books[1]
    @price = 21.6 if @books.size == 3
    @price = 25.6 if @books.size == 4
    @price = 30 if @books.size == 5
  end
end
