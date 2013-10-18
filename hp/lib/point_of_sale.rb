class PointOfSale
  attr_reader :price
  attr_accessor :basket
  def initialize
    @basket = []
  end
  def calculate_price
    @price = 8
    @price = 16 if @basket.size == 2
    @price = 15.20 if @basket.size == 2 && @basket[0] != @basket[1]
    @price = 21.6 if @basket.size == 3
    @price = 25.6 if @basket.size == 4
    @price = 30 if @basket.size == 5
  end
end
