def get_random_word
  words = File.open("words.txt", "r")
  random = Random.new
  begin
    word = words.readlines[random.rand(1..61406)]
    word.length < 5 ? raise("Wrong word") : nil
  rescue
    retry
  end
  return word.downcase.chomp.split("")
end

