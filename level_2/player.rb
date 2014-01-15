class Player

	def initialize
		@directionOfStairs = nil
	end

  def play_turn(warrior)
    
    @directionOfStairs = warrior.direction_of_stairs


    if warrior.feel(@directionOfStairs).enemy?
    	warrior.attack!(@directionOfStairs)
    else
    	warrior.walk!(@directionOfStairs)
    end


  end
end
