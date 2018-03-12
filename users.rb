require_relative 'verifier'

class users
	attr_accessor :name, :coins

def initialize
	@name = name
	@coins = coins
end

def check_name giver, receiver, amount
	giver_exists = false
	receiver_exists = false
	@names.each {|x| 
		if giver == x
			giver.coins -= amount
			giver_exists = true
		end
		if receiver == x
			receiver.coins += amount
			receiver_exists = true
		end	
	}

	if(!giver_exists)
		names << giver
		giver.coins -= amount
	end

	if(!receiver_exists)
		names << receiver
		receiver.coins += amount
	end

end

end