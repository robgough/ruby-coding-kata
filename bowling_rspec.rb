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
    bowls = [[10], [10], [10], [1,0]]
    expect(calculate_score(bowls)).to eq(63)
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
  it 'should be able to correctly score a full game' do
    bowls = [[10],[10],[10],[10],[10],[10],[10],[10],[10],[10,10,10]]
    expect(calculate_score(bowls)).to eq(300)
  end
end

def calculate_score(bowls)
  score = 0
  frames = bowls.inject([]) { |a, f| a << Frame.new(f) }

  frames.each_with_index do |frame, i|
    score += frame.score(*get_next_throws(frames, i))
  end
  score
end

def get_next_throws(frames, i)
  next_throw, next_again_throw = 0,0
  return 0,0 unless frames[i+1]
  next_throw = frames[i+1].bowls[0]
  # if a strike was scored, then we need to jump ahead *again*
  if next_throw == 10
    next_again_throw = frames[i+2].bowls[0] if frames[i+2]
  else
    next_again_throw = frames[i+1].bowls[1]
  end 
  [next_throw, next_again_throw]
end

class Frame
  attr_reader :bowls

  def initialize(bowls)
    @bowls = bowls
  end

  def score(next_throw, next_again_throw)
    total_score = sum_bowls

    return total_score unless next_throw 

    total_score += next_throw if spare? || strike?
    total_score += next_again_throw if strike?

    total_score
  end

  private

  def sum_bowls
    @bowls.inject :+
  end

  def strike?
    @bowls.first == 10
  end

  def spare?
    sum_bowls == 10
  end
end
