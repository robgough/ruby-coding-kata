#Create a program, which, given a valid sequence of rolls for one line of American Ten-Pin Bowling, produces the total score for the game. Here are some things that the program will not do:
#
#We will not check for valid rolls.
#We will not check for correct number of rolls and frames.
#We will not provide scores for intermediate frames.
#Depending on the application, this might or might not be a valid way to define a complete story, but we do it here for purposes of keeping the kata light. I think you'll see that improvements like those above would go in readily if they were needed for real.
#We can briefly summarize the scoring for this form of bowling:
#
#Each game, or "line" of bowling, includes ten turns, or "frames" for the bowler.
#In each frame, the bowler gets up to two tries to knock down all the pins.
#If in two tries, he fails to knock them all down, his score for that frame is the total number of pins knocked down in his two tries.
#If in two tries he knocks them all down, this is called a "spare" and his score for the frame is ten plus the number of pins knocked down on his next throw (in his next turn).
#If on his first try in the frame he knocks down all the pins, this is called a "strike". His turn is over, and his score for the frame is ten plus the simple total of the pins knocked down in his next two rolls.
#If he gets a spare or strike in the last (tenth) frame, the bowler gets to throw one or two more bonus balls, respectively. These bonus throws are taken as part of the same turn. If the bonus throws knock down all the pins, the process does not repeat: the bonus throws are only used to calculate the score of the final frame.
#The game score is the total of all frame scores.
#More info on the rules at: www.topendsports.com/sport/tenpin/scoring.htm

describe 'bowling kata' do
  describe 'frame' do
    it 'can record a bowl' do
      f = Frame.new
      f.perform_bowl 3
      expect(f.pins_knocked_down).to eq(3)
    end

    it 'can record a second bowl' do
      f = Frame.new
      f.perform_bowl 3
      f.perform_bowl 2
      expect(f.pins_knocked_down).to eq(5)
      expect(f.spare?).to be_false
      expect(f.strike?).to be_false
    end

    it 'can detect a spare' do
      f = Frame.new
      f.perform_bowl 8
      f.perform_bowl 2
      expect(f.spare?).to be_true
      # is it OK to lump in checks like this?
      expect(f.strike?).to be_false
    end

    it 'can detect a strike' do
      f = Frame.new
      f.perform_bowl 10
      expect(f.spare?).to be_false
      expect(f.strike?).to be_true
    end
  end
end

class Bowling
end

class Frame
  def initialize
    @tries = []
  end
  
  def perform_bowl(pins_knocked_down)
    @tries << pins_knocked_down
  end

  def pins_knocked_down
    @tries.inject(0) do |total, pins|
      total += pins
    end
  end

  def spare?
    pins_knocked_down == 10 && @tries.count == 2
  end

  def strike?
    pins_knocked_down == 10 && @tries.count == 1
  end
end
