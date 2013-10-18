require 'point_of_sale'

describe "point_of_sale" do
  it 'should find the price of 1 book' do
    pos = PointOfSale.new
    pos.basket << [1]
    pos.calculate_price
    expect(pos.price).to eq(8)
  end
end
