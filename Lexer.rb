class Scanner
  # Constructor - Is passed a file to scan and outputs a token
  #               each time nextToken() is invoked.
  #   @c        - A one character lookahead
  def initialize(filename)
    @f = File.open(filename,'r:utf-8') if File::exists?(filename)
    if !@f
      abort("File does not exist!")
    end

    if (! @f.eof?)
      @c = @f.getc()
    else
      @c = "eof"
      @f.close()
    end

  end

  def nextCh()
    if (! @f.eof?)
      @c = @f.getc()
    else
      @c = "eof"
    end
    return @c
  end

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
    elsif (numeric?(@c))
      str = ""
      while numeric?(@c)
        str += @c
        nextCh()
      end
      tok = Token.new(Token::INT,str)
      return tok
    elsif (letter?(@c))
      str = ""
      while letter?(@c)
        str += @c
        nextCh()
      end
      if (str == "print")
        tok = Token.new(Token::PRINT,str)
      else
        tok = Token.new(Token::ID,str)
      end
      return tok
    end

    case @c
    when '('
      tok = Token.new(Token::LPAREN,"(")
      nextCh()
      return tok
    when ')'
      tok = Token.new(Token::RPAREN,")")
      nextCh()
      return tok
    when '+'
      tok = Token.new(Token::ADDOP,"+")
      nextCh()
      return tok
    when '-'
      tok = Token.new(Token::SUBOP,"-")
      nextCh()
      return tok
    when '/'
      tok = Token.new(Token::DIVOP,"/")
      nextCh()
      return tok
    when '*'
      tok = Token.new(Token::MULTOP,"*")
      nextCh()
      return tok
    when '='
      nextCh()
      tok = Token.new(Token::ASSGN,"=")
      return tok
    else
      tok = Token.new(Token::UNKNWN,@c)
      nextCh()
      return tok
    end
  end
end
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