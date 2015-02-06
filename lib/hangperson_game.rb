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
  	@word_with_guesses = ''
  	word.length.times {@word_with_guesses+='-'}
  end

  def guess(guess)
  	if guess=='' || !(guess =~ /[A-Za-z]/) || guess==nil
  		raise ArgumentError
  	elsif @word.include? guess 
  		occurrences = (0 ... word.length).find_all { |i| word[i] == guess }
  		occurrences.each {|i| @word_with_guesses[i]=guess}
  		@guesses += guess if !@guesses.include? guess
  	else
  		@wrong_guesses += guess if !@wrong_guesses.include? guess
  	end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
