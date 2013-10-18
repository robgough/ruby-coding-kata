require "point_of_sale"

module DomainDriver
  def pos
    @pos ||= PointOfSale.new
  end

  def total_price
    pos.calculate_price
    pos.price
  end

  def add_to_basket books
    pos.basket += books
  end

  def number_of_books
    pos.basket.size
  end
end
World(DomainDriver)

