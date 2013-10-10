describe 'harry potter kata' do
  let(:pos) { PointOfSale.new } 

  it 'should cost 8 EUR for one book' do
    price_in_eur = pos.calculate_price [1]
    expect(price_in_eur).to eq(8)
  end

  it 'should have 5% discount on two different books' do
    price = pos.calculate_price [1, 2]
    expect(price).to eq(60.80) # 5% = 3.20
  end

  it 'should have no discount on two of the same books' do
    price = pos.calculate_price [1, 1]
    expect(price).to eq(16)
  end
end

class PointOfSale
  def calculate_price(books)
    price = 0
    
    if books.length == 1
      price = 8
    end

    if books.length == 2
      if books[0] == books [1]
        price = 
        price = 16
    end

    price
  end
end
