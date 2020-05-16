
class Hangman
    attr_accessor :secret_word
    def initialize(guesses = 5)
        @secret_word = File.readlines("wordbank.txt").map(&:chomp).sample
        @hidden_word = Array.new(@secret_word.length) {"_"}
        @attempted_chars = []
        @guesses = guesses
    end
    
    def run
        until lose? || win?
            display
            puts "Enter a char:"
            guess = gets.chomp
            while already_guessed?(guess)
                puts "Enter a char:"
                guess = gets.chomp
            end
            if @secret_word.include?(guess)
                correct_guess(guess)
            else
                wrong_guess(guess)
            end
        end
        puts "The word was #{@secret_word}."
    end

    def already_guessed?(guess)
        if @hidden_word.include?(guess)
            puts "Already guessed that"
            true
        end
    end

    def win?
        if @hidden_word.none? {|letter| letter == "_"}
        puts "Congratulations, you have won!"
        true
        end
    end

    def lose?
       if @guesses == 0
        puts "Sorry, you have lost!"
        true
       end
    end

    def display
        puts "Incorrect Guesses Remaining: #{@guesses}"
        puts "Attempted Chars: #{@attempted_chars}"
        puts "Word: #{@hidden_word}"
    end

    def correct_guess(guess)
        @secret_word.split("").each_with_index do |letter, i|
            if letter == guess
                @hidden_word[i] = guess
            end
        end
        unique_guess(guess)
    end

    def wrong_guess(guess)
        @guesses -= 1
        unique_guess(guess)
    end

    def unique_guess(guess)
        @attempted_chars << guess if !@attempted_chars.include?(guess)
    end
end

Hangman.new.run