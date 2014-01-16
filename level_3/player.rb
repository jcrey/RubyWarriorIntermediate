class Player

	def initialize
		@maxHealth = 20
		@minHealth = 10
		@isFullRecover = true
		@healthLevelLastTurn = 20
		@directionOfStairs = nil
		@directions = [:forward, :backward, :right, :left]
		@enemyDirections = []
		@mostCloseEnemiesAreBinded = false
		@warrior = nil
    @imBeingAttack2 = false
    @isResting = false
    @foundCaptives = false
	end

  def play_turn(warrior)

  	@warrior = warrior

  	bindCloseEnemies! unless @mostCloseEnemiesAreBinded 

  	rest! if (needsRest? && !imBeingAttack?)

	  attackEnemiesBinded! if @mostCloseEnemiesAreBinded && !@isResting

    rescueCaptives! if !@isResting && @enemyDirections.empty?

    warrior.walk!(warrior.direction_of_stairs) if !@isResting && @enemyDirections.empty? && !@foundCaptives

  end

  def rescueCaptives!
    @directions.each do |direction|
      space = @warrior.feel(direction)

      if  space.captive? 
        @foundCaptives = true
        @warrior.rescue!(direction)
        return true
      end
    end
    @foundCaptives = false
  end

  def bindCloseEnemies!()

  	@directions.each do |direction|
  		space = @warrior.feel(direction)

	   	if  space.enemy? 
			  @enemyDirections << direction
  			@warrior.bind!(direction)
  			return false
  		end
    end

  	if !@enemyDirections.empty?
  		@mostCloseEnemiesAreBinded = true	
  	end
	
  end

  def attackEnemiesBinded!()
  	if !@warrior.feel(@enemyDirections.last).empty?
		@warrior.attack!(@enemyDirections.last)
	else
		@enemyDirections.pop
    if @enemyDirections.empty?
      @mostCloseEnemiesAreBinded = false
    end
	end
  end

  def needsRest?()
  	if @warrior.health < @minHealth || !@isFullRecover
  		@isFullRecover = false
  		return true
  	else
  		return false
	  end
  end

  def rest!()
  	if @warrior.health < @maxHealth
  		@warrior.rest!
      @isResting = true
  	else
      @isResting = false
  		@isFullRecover = true
      @healthLevelLastTurn  = @warrior.health
  	end
  end

  def imBeingAttack?()

  	if  @warrior.health < @healthLevelLastTurn
  		@healthLevelLastTurn = @warrior.health
  		return true
  	else
  		return false
  	end
  end

end
