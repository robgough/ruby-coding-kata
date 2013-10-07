describe 'bowling kata' do
  it 'should be able to score one frame' do
    bowls = [[2,3]]
    expect(calculate_score(bowls)).to eq(5)
  end
  it 'should be able to score two frames' do
    bowls = [[2,3],[2,3]]
    expect(calculate_score(bowls)).to eq(10)
  end
  it 'should be able to score ten frames' do
    bowls = [[2,3]] * 10
    expect(calculate_score(bowls)).to eq(50)
  end
  it 'should be able to correctly score a spare' do
    bowls = [[2, 8], [1,0]]
    expect(calculate_score(bowls)).to eq(12)
  end
  it 'should be able to correctly score a strike' do
    bowls = [[10], [1,2]]
    expect(calculate_score(bowls)).to eq(16)
  end
  it 'should be able to correctly score two spares in a row' do
    bowls = [[8,2], [6,4], [3,0]]
    expect(calculate_score(bowls)).to eq(32)
  end
  it 'should be able to correctly score a double' do
    bowls = [[10], [10], [3,0]]
    expect(calculate_score(bowls)).to eq(39)
  end
end

def calculate_score(bowls)
  score = 0
  frames = []
  to_be_added = []

  #puts "\nCalculating Score for #{bowls.to_s}"

  bowls.each do |f|
    frames << Frame.new(f)
  end
  
  frames.each_with_index do |frame, i|
    #puts "frame i scored #{frame.score(frames[i+1])}"
    score += frame.score(frames[i+1])
  end
  score
end

class Frame
  attr_reader :bowls

  def initialize(bowls)
    @bowls = bowls
    if @bowls.length < 2
      @bowls << 0
    end
  end

  def last?
    @bowls.count > 2
  end

  def strike?
    @bowls.first == 10
  end

  def spare?
    !last? && @bowls.first + @bowls.last == 10
  end

  def score(next_frame)
    total_score = @bowls[0] + @bowls[1]
    
    return total_score if next_frame.nil?

    total_score += next_frame.bowls[0] if spare? || strike?
    total_score += next_frame.bowls[1] if strike?

    total_score
  end
end
