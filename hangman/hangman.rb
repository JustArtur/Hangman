require_relative 'game_bot'
require_relative 'human'

def check_win(encrypted_word, number_of_mistakes)
  if number_of_mistakes >= 6
    puts "Hangman won!"
    return true
  end
  unless encrypted_word.include?("_")
    print "Host win!"
    return true
  end
end

def start_game
  puts "Hangman initialized!"
  puts "Do you want to play with bot y/n?"
  answer = gets.chomp

  if answer == "y"
    puts "Game with bot started..."
    return get_random_word
  elsif answer == "n"
    return input_word
  else
    raise "Please, restart the game"
  end
end

def input_letter(word, used_letters, encrypted_word, number_of_mistakes)
  print "Enter letter: "
  char = gets.chomp.downcase
  if word.include?(char)
    begin
      char_index = word.index(char)
      encrypted_word[char_index] = char
      word[char_index] = "_"
      word.include?(char) ? raise("error") : nil
    rescue
      retry
    end
  else
    number_of_mistakes += 1
    used_letters.append(char)
  end
end

def create_encrypted_word(word)
  encrypted_word = Array.new(word.length, "_")
  encrypted_word[encrypted_word.length - 1] = word.last
  encrypted_word[0] = word.first
  word[0] = "_"
  word[word.length - 1] = "_"
  return encrypted_word
end

number_of_mistakes = 0
used_letters = []

word = start_game
encrypted_word = create_encrypted_word(word)

while true
  system "cls"
  print encrypted_word.join, "\n"
  input_letter(word, used_letters, encrypted_word, number_of_mistakes)
  print "Invalid characters: #{used_letters}", "\n"
  print "Number of mistakes: #{number_of_mistakes}.", "\n"
  check_win(encrypted_word, number_of_mistakes) ? break : nil
end
