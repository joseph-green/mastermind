class Board
	$colours = ["red","blue","yellow","green","orange","purple","black","white","grey","brown","pink","turquoise"]
	@@board = ["","","",""]
	def initialize(difficulty)
		@difficulty = difficulty

	end
	def self.colour_translate(num)
		case(num)
		when 1
			return "red"
		when 2 
			return "blue"
		when 3
			return "yellow"
		when 4
			return "green"
		when 5
			return "orange"
		when 6
			return "purple"
		when 7
			return "black"
		when 8
			return "white"
		when 9
			return "grey"
		when 10
			return "brown"
		when 11
			return "pink"
		when 12
			return "turquoise"
		end

	end
	public
	
	def new_board
		x = 0
		if @difficulty == "hard"
			x = 12
		elsif @difficulty == "medium"
			x = 9
		else
			x = 6
		end
		4.times do |i|
			@@board[i-1] = Board.colour_translate(rand(1..x))
		end

	end 
	def self.display
		puts "----------------------------------------"
		puts "-               THE ANSWER             -"
		puts "----------------------------------------"
		@@board.each {|i| print i.upcase + " "}
		print "\n"
	end
	def self.show_colours(diff)
		puts "Red \nBlue \nYellow \nGreen \nOrange \nPurple "
		puts "Black \nWhite \nGrey" if  diff == 'medium' || diff == 'hard'
		puts "Brown \nPink \nTurquoise " if diff == 'hard'

	end
	def self.compare(array)
		puts "The boards are equal!" if array == @@board
		similar = 0
		exact = 0
		array.each {|i| similar += 1 if @@board.include?(i) && @@board.index(i) != array.index(i) && @@board.select{|x|@@board.include?(x)}.length >similar}
		array.each {|i| exact += 1 if @@board.index(i) == array.index(i)}
		
		return {"exact" => exact, "similar" => (similar) , "different" => (array.length - exact - similar) }  
	end
	def win?(guess)
		return true if guess.fetch('exact') == 4
		return false
	end
	def self.clear_board
		@@board = ['','','','']
	end
	
end
class Player
	def initialize(diff)
		@difficulty = diff
	end
	def guess

		puts "Here are the colours:"
		Board.show_colours(@difficulty)
		puts "What colour is in position 1?" ; c1 = gets.chomp!.downcase until check_validity(c1)
		puts "What colour is in position 2?" ; c2 = gets.chomp!.downcase until check_validity(c2)
		puts "What colour is in position 3?" ; c3 = gets.chomp!.downcase until check_validity(c3)
		puts "What colour is in position 4?" ; c4 = gets.chomp!.downcase until check_validity(c4)
		
		
		guess = [c1,c2,c3,c4]
		guess.each {|i|Board.colour_translate(i) if i.is_a?(Integer)}
		return Board.compare(guess)


		



		


	end
	private
	def check_validity(input)
		
		unless $colours.include?(input)
			return false	
		else
			return true
		end 

	end

end
def game
	puts "----------------------------------------"
	puts "-              MASTERMIND              -"
	puts "----------------------------------------"
	diff = nil
	until diff == 'easy' || diff = 'medium' || diff == 'hard'
	puts "What difficulty? (easy, medium, hard)"
 	diff = gets.chomp.downcase
 	end

	board = Board.new(diff) 
	player = Player.new(diff)
	board.new_board
	player_win = false
	10.times do |i|
		puts "----------------------------------------"
	 	puts "-               TURN #{i + 1}                 -"
		puts "----------------------------------------"
		
		combo = player.guess
		print "EXACT: #{combo['exact']} "
		print "SIMILAR: #{combo['similar']} "
		print "DIFFERENT: #{combo['different']}\n"
		player_win = true; break if board.win?(combo) == true 	
	end
	if player_win == true
		board.display
		puts "----------------------------------------"
		puts "-               YOU WIN!               -"
		puts "----------------------------------------"
	else
		board.display
		puts "----------------------------------------"
		puts "-              YOU LOSE!               -"
		puts "----------------------------------------"
	end

end
game