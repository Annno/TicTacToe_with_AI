class Game
	@@win_vector = [['00','11','22'],['00','01','02'],['10','11','12'],['20','21','22'],
									['00','10','20'],['01','11','21'],['02','12','22'],['02','11','20']]
	attr_accessor :player1, :player2

	def initialize(p1_name,p2_name)
		@board = [['#','#','#'],['#','#','#'],['#','#','#']]
		@player1 = Player.new(p1_name)
		@player2 = Player.new(p2_name)
		@winner = 0
		@turn = 0
		@xs=[]
		@xo=[]
	end

	def new_game
		puts "\nWelcome to TicTacToe!"
		puts "\nPick a name for p1:"
		p1=gets.chomp
		puts "\nPick a name for p2:"
		p2=gets.chomp
		game1= Game.new(p1,p2)
		game1.start_game
	end

	def start_game
		show_board
	  play_hand
	end

	def play_hand
		while (@winner==0)
			if (check_turn=="AI")
				ai
				show_board
			else
				puts "\n\nIt's "+ check_turn + "s turn! \nPick a place that you wanna play(ex: 00) :"
				answer = gets.chomp
				add_xo(answer)
				show_board
			end
			check_win
			@turn += 1
			if @turn==10
				@winner = 2
				check_win
			end
		end
	end

	def next_turn
		xss=[]
		@xs.each do |i|
			xss.push(i)
		end
		xos=[]
		@xo.each do |i|
			xos.push(i)
		end
		a = ['00','01','02','10','11','12','20','21','22']
		a.each do |i|
			if (!xss.include?(i) && !xos.include?(i) && xss.count<5 && xos.count<5)
				xos[@xo.count]=i
				if check_win_next_turn(xos)
					return i
				end
				xss[@xs.count]=i
				if check_win_next_turn(xss)
					return i
				end
			end	
		end
		return false
	end

	def ai
		if (next_turn==false)
			a = rand(0..2).to_s + rand(0..2).to_s
		else
			a = next_turn
		end
		print"\n"
		b = @board[a[1].to_i][a[0].to_i]
		if (b=="#" && @winner==0)
			add_xo(a)
		elsif (@winner==0 && @xs.count<5)
			ai
		end

	end

	def check_win_next_turn(v)
		@@win_vector.each do |i|
		a=0
			i.each do |j|
				a+=1 if v.include?(j)
				if (a==3) 
					return true
				end
			end
		end
		false
	end

	def check_win
		answer="n"
		if (@winner==2)
			puts "\n There was a tie! Wanna play another game?"
			answer=gets.chomp
			if (answer=="y")
				new_game
			end
		end

		@@win_vector.each do |i|
			a=0
			b=0
			i.each do |j|
				a+=1 if @xs.include?(j)
				if (a==3 && @winner==0) 
					puts "\n" + check_turn + " has won!! Congrats \nWould you like to play another game? (y/n)"
					answer=gets.chomp
					@winner=1
					if (answer=="y")
						new_game
					end
				end
				b+=1 if @xo.include?(j)
				if (b==3 && @winner==0) 
					puts "\n" + check_turn + " has won!! Congrats \nWould you like to play another game? (y/n)"
					answer=gets.chomp
					@winner=1
					if (answer=="y")
						new_game
					end
				end
			end
		end
		answer
	end

	def add_xo(answer,a=check_turn)
		if (a==@player1.name)
			@board[answer[1].to_i][answer[0].to_i]="X"
			@xs.push(answer) 
		else
			@board[answer[1].to_i][answer[0].to_i]="O"
			@xo.push(answer)
		end

	end

	def check_turn
		if(@turn%2==0)
			return @player1.name
		else
			return @player2.name
		end
	end

	def show_board
		print "\n   0 1 2"
		@board.each_with_index do |i,indexi|
			print "\n " + indexi.to_s + " "
			i.each_with_index do |j,indexj|
			print j.to_s + " "
			end 
		end
	end

	class Player
		
		attr_accessor :name

		def initialize(name)
			@name = name
		end

	end

end

puts "\nWelcome to TicTacToe!"
puts "\nPick a name for p1:"
p1=gets.chomp
puts "\nPick a name for p2(If you wanna play with the computer pick AI):"
p2=gets.chomp
game1= Game.new(p1,p2)
game1.start_game