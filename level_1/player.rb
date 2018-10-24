class Player

	def initialize
		@directionOfStairs = nil
	end

  def play_turn(warrior)
    
    @directionOfStairs = warrior.direction_of_stairs

    warrior.walk!(@directionOfStairs)

  end
end
