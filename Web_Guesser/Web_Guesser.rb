require 'sinatra'
# require 'sinatra/reloader' 
@@turns = 5
@@secret_number = rand(100)
win = false
@@color = "white"
@@answer = "X"
@@cheat = false
get '/' do
	guess = params['guess']
	@@color = "white"
	message = check_guess(guess.to_i,@@secret_number,win)
	erb :index, :locals => {:secret => @@secret_number, :message => message , :turns => @@turns, :color => @@color, :answer => @@answer, :cheat => @@cheat}
end
# This function checks the condition for winning and the number of turns remaining.
def check_guess(guess,answer,win)
	if win != true  #If the player has not won yet
	@@answer = "X"  
		if @@turns == 0
			@@answer = @@secret_number
			@@secret_number = rand(100)
			@@turns = 5
			@@color = "white"
			return "GAME OVER!"
		elsif @@turns != 0
			if guess > 100 or guess < 0
				@@turns -= 1
				return "Invalid input!"
			elsif (guess - answer).abs <= 5 and (guess - answer).abs != 0
				@@turns -= 1
				@@color = "#ff9999"
				return "You're very close!"
			elsif (guess - answer).abs == 0
				win = true
				@@color = "#b2ffb2"
				@@answer = @@secret_number
				@@turns = 5
				@@secret_number = rand(100)
				return "You Won! Congrats."
			elsif (guess - answer).abs <= 10
				@@turns -= 1
				@@color = "#ff7f7f"
				return "You're close!"
			elsif (guess - answer).abs <= 15
				@@color = "#ff4c4c"
				@@turns -= 1
				return "Not very close!"
			elsif (guess - answer).abs > 15
				@@color = "#ff0000"
				@@turns -= 1
				return "You're hopeless!"
			end
		end	
	elsif win == true	#If the player won!
		@@answer = @@secret_number
		@@secret_number = rand(100)
		@@turns = 5
		return "You Won!"
	end
end

		
			