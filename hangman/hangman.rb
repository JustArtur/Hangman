class Hangman
  def initialize
    @lives = 7
    @wrong_guesses = []
  end

  def choose_player
    puts "Do you want to play with bot y/n?"
    answer = gets.chomp

    if answer == "y"
      puts "Game with bot started..."
      get_secret_word_bot
    elsif answer == "n"
      input_secret_word
    else
      raise "Please, restart the game"
    end
  end

  def get_secret_word_bot
    words = File.open("words.txt", "r")
    begin
      secret_word = words.readlines.sample
      secret_word.length < 5 ? raise("Wrong word") : nil
    rescue
      retry
    end
    @secret_word = secret_word.chomp.downcase.split("")
  end

  def input_secret_word
    print "Please, enter a secret word: "
    @secret_word = gets.chomp.downcase.split("")
  end

  def setup_board
    @board = Array.new(@secret_word.size, "_")
    @board[0] = @secret_word.first
    @board[@board.length] = @secret_word.last
  end

  def make_guess
    gets.chomp.downcase
  end

  def start_game
    # Выбрать игрока
    # Получить на вход букву
    # Проверить букву в секретном слове
    # Проверить победу или поражение
    puts "Hangman game initialize..."
    choose_player
    setup_board
    output_board
    begin
      print "Please, make guess: "
      @guess = make_guess
      check_input
      update_board
      output_wrong_guesses_and_lives
      output_board
      check_win
    rescue
      retry
    end
  end

  def check_win
    if not(@board.include?("_"))
      puts "Hangman won!"
    elsif not(@lives > 0)
      puts "Host win!"
    else
      raise "Next move"
    end
  end

  def check_input
    if @guess.length > 1
      puts "You need to enter one letter."
      output_wrong_guesses_and_lives
      output_board
      raise "Wrong input"
    elsif @wrong_guesses.include?(@guess) or @board.include?(@guess)
      puts "This letter has already been used."
      output_wrong_guesses_and_lives
      output_board
      raise "Wrong input"
    end
  end

  def update_board
    if @secret_word.include?(@guess)
      begin
        guess_index = @secret_word.index(@guess)
        @board[guess_index] = @guess
        @secret_word[guess_index] = "_"
        @secret_word.include?(@guess) ? raise("error") : nil
      rescue
        retry
      end
    else
      @lives -= 1
      puts "Wrong guess("
      @wrong_guesses.append(@guess)
    end
  end

  def output_board
    print @board.join(""), "\n"
  end

  def output_wrong_guesses_and_lives
    puts "Your have #{@lives} lives."
    puts "Wrong guesses: #{@wrong_guesses.join(",")}."
  end
end

game = Hangman.new
game.start_game