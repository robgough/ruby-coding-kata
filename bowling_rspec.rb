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
  it 'should be able to correctly score a turkey' do
    bowls = [[10], [10], [10]]
    expect(calculate_score(bowls)).to eq(60)
  end
  it 'should be able to handle an endgame with a spare' do
    bowls = [[7, 3, 2]]
    expect(calculate_score(bowls)).to eq(12)
  end
  it 'should be able to handle an endgame with a strike' do
    bowls = [[10, 2, 3]]
    expect(calculate_score(bowls)).to eq(15)
  end
  it 'should be able to handle an endgame with a double' do
    bowls = [[10, 10, 3]]
    expect(calculate_score(bowls)).to eq(23)
  end
  it 'should be able to handle an endgame with a turkey' do
    bowls = [[10,10,10]]
    expect(calculate_score(bowls)).to eq(30)
  end
  it 'should be able to handle an endgame with a strike then spare' do
    bowls = [[10, 7, 3]]
    expect(calculate_score(bowls)).to eq(20)
  end
  it 'should be able to handle an endgame with a spare then strike' do
    bowls = [[7,3,10]]
    expect(calculate_score(bowls)).to eq(20)
  end
  it 'should be able to correctly score a full game' do
    bowls = [[5,3],[5,2],[2,6],[9,1],[3,7],[10],[6,2],[5,2],[5,4],[2,8,10]]
    expect(calculate_score(bowls)).to eq(118)
  end
end

def calculate_score(bowls)
  score = 0
  frames = []
  to_be_added = []

  bowls.each do |f|
    frames << Frame.new(f)
  end
  
  frames.each_with_index do |frame, i|
    next_throw, next_again_throw = get_next_throws(frames, i)
    score += frame.score(next_throw, next_again_throw)
  end
  score
end

def get_next_throws(frames, i)
  next_throw, next_again_throw = 0,0
  return 0,0 if frames[i+1].nil?
  next_throw = frames[i+1].bowls[0]
  # if a strike was scored, then we need to jump ahead *again*
  if next_throw == 10
    next_again_throw = frames[i+2].bowls[0] if !frames[i+2].nil?
  else
    next_again_throw = frames[i+1].bowls[1]
  end 
  return next_throw, next_again_throw
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

  def score(next_throw, next_again_throw)
    total_score = @bowls[0] + @bowls[1]
    
    return total_score if next_throw.nil?
    return score_endgame if @bowls.count > 2

    total_score += next_throw if spare? || strike?
    total_score += next_again_throw if !next_throw.nil? && strike?

    total_score
  end

  private

  def score_endgame
    score = 0
    if @bowls.length < 3
      score += @bowls[0] + @bowls[1]
    else
      score += @bowls.inject(0) do |sum, bowl|
                sum += bowl
               end
    end
    score
  end
end
