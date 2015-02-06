class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses

  def initialize(word)
  	@word = word
  	@guesses = ''
  	@wrong_guesses = ''
  end

  def guess(guess)
  	if guess=='' || !(guess =~ /[A-Za-z]/) || guess==nil
  		raise ArgumentError
  	elsif @word.include? guess 
  		if !@guesses.include? guess
  			@guesses += guess
  		else
  			false
  		end
  	else
  		if !@wrong_guesses.include? guess
  			@wrong_guesses += guess 
  		else
  			false
  		end
  	end
  end

  def check_win_or_lose
  	if @wrong_guesses.length >= 7
  		:lose 
  	elsif !(word_with_guesses.include? '-')
  		:win 
  	else
  		:play
  	end
  end

  def word_with_guesses
  	word_with_guesses = ''
  	@word.split("").each do |l|
  		if @guesses.include? l 
  			word_with_guesses += l 
  		else
  			word_with_guesses += '-'
  		end
  	end
  	return word_with_guesses
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
