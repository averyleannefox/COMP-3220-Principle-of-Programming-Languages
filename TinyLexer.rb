#
#  Class Lexer - Reads a TINY program and emits tokens
#
class Lexer
	# Constructor - Is passed a file to scan and outputs a token
	#               each time nextToken() is invoked.
	#   @c        - A one character lookahead
	def initialize(filename)
		if File.exist? (filename)
		# Need to modify this code so that the program
		# doesn't abend if it can't open the file but rather
		# displays an informative message
		@f = File.open(filename,'r:utf-8')

		# Go ahead and read in the first character in the source
		# code file (if there is one) so that you can begin
		# lexing the source code file
		if (! @f.eof?)
			@c = @f.getc()
		else
			@c = "eof"
			@f.close()
		end

		else
			puts "File does not exits. Please enter a valid file name."
			@c = "eof"
			end

	end



	# Method nextCh() returns the next character in the file
	def nextCh()
		if (! @f.eof?)
			@c = @f.getc()
		else
			@c = "eof"
		end

		return @c
	end




	# Method nextToken() reads characters in the file and returns
	# the next token
	def nextToken()
		if @c == "eof"
			return Token.new(Token::EOF,"eof")

		elsif (whitespace?(@c))
			str =""

			while whitespace?(@c)
				str += @c
				nextCh()
			end

			tok = Token.new(Token::WS,str)
			return tok

		elsif letter?(@c)
			str = ""
			while letter?(@c)
				str += @c
				nextCh
			end

			if str == "print"
				tokNum1 = Token.new(Token::PRINT, str)
				return tokNum1
			else
				tokNum2 = Token.new(Token::ID, str)
				return tokNum2
			end

		elsif numeric?(@c)
			str = ""
			while numeric?(@c)
				str += @c
				nextCh()
			end

			tokNum3 = Token.new(Token::INT,str)
			return tokNum3

		elsif @c == "="
			nextCh()
			tokNum4 = Token.new(Token::ASSGN,"=")
			return tokNum4

		elsif @c == "("
			nextCh()
			tokNum5 = Token.new(Token::LPAREN,"(")
			return tokNum5

		elsif @c == ")"
			nextCh()
			tokNum6 = Token.new(Token::RPAREN,")")
			return tokNum6

		elsif @c == "+"
			nextCh()
			tokNum7 = Token.new(Token::ADDOP,"+")
			return tokNum7

		elsif @c == "-"
			nextCh()
			tokNum8 = Token.new(Token::SUBOP,"-")
			return tokNum8

		elsif @c == "/"
			nextCh()
			tokNum9 = Token.new(Token::DIVOP,"/")
			return tokNum9

		elsif @c == "*"
			nextCh()
			tokNum10 = Token.new(Token::MULTOP,"*")
			return tokNum10
		else
			tokNum11 = Token.new(Token::UNKNWN,@c)
			nextCh()
			return tokNum11
		end




	end



			# elsif ...
			# more code needed here! complete the code here
			# so that your scanner can correctly recognize,
			# print (to a text file), and display all tokens
			# in our grammar that we found in the source code file

			# FYI: You don't HAVE to just stick to if statements
			# any type of selection statement "could" work. We just need
			# to be able to programatically identify tokens that we
			# encounter in our source code file.

			# don't want to give back nil token!
			# remember to include some case to handle
			# unknown or unrecognized tokens.
			# below is an example of how you "could"
			# create an "unknown" token directly from
			# this scanner. You could also choose to define
			# this "type" of token in your token class





	#
	# Helper methods for Scanner
	#
	def letter?(lookAhead)
		lookAhead =~ /^[a-z]|[A-Z]$/

	end

	def numeric?(lookAhead)
		lookAhead =~ /^(\d)+$/
	end

	def whitespace?(lookAhead)
		lookAhead =~ /^(\s)+$/
	end

	end