=begin
This method identifies the zeroes in the input word(s) and returns a list of characters and indices
associated with a zero.
=end
def find_zeros(input_word)
zeros = []
for i in 0..5 do
    if input_word[i+5] == '0'
        zeros.push(input_word[i])
        zeros.push(i)
    end
end
zeros
end
=begin
This method identifies the ones in the input word(s) and returns a list of characters and indices
associated with a one.
=end
def find_ones(input_word)
    ones = []
    for i in 0..5 do
        if input_word[i+5] == '1'
            ones.push(input_word[i])
            ones.push(i)
        end
    end
    ones
end
=begin
This method identifies the two in the input word(s) and returns a list of characters and indices
associated with a two.
=end
def find_twos(input_word)
    twos = []
    for i in 0..5 do
        if input_word[i+5] == '2'
            twos.push(input_word[i])
            twos.push(i)
        end
    end
    twos
end
=begin
This method takes an analysis word in the file and processes it to see if there are any 0-associated characters
occurring where they should not be, and returns an appropriate boolean.
=end
def compare_zeros(analysis_word, zero_chars, one_chars, two_chars)
    is_in_word = true
    i = 0
    while i < zero_chars.size - 1
        char = zero_chars[i]
        pos = zero_chars[i + 1]
        if analysis_word[pos] != char && (one_chars.include?(char) || two_chars.include?(char))
            i=i+2
            next
        elsif !analysis_word.include?(char)
            i=i+2
            next
        else
            is_in_word = false
            break
        end
    end
    is_in_word
end
=begin
This method takes an analysis word in the file and processes it to see if there are any 1-associated characters
occurring where they should not be, and returns an appropriate boolean.
=end
def compare_ones(analysis_word, one_chars)
    is_in_word = true
    i = 0
    while i < one_chars.size - 1
        char = one_chars[i]
        pos = one_chars[i + 1]
        if analysis_word.include?(char) && analysis_word[pos] != char
            i=i+2
            next
        else
            is_in_word = false
            break
        end
    end
    is_in_word
end
=begin
This method takes an analysis word in the file and processes it to see if there are any 2-associated characters
occurring where they should be, and returns an appropriate boolean.
=end
def compare_twos(analysis_word, two_chars)
    fits = true
    i = 0
    while i < two_chars.size - 1
        char = two_chars[i]
        pos = two_chars[i + 1]
        if analysis_word[pos] == char
            i += 2
            next
        else
            fits = false
            break
        end
    end
    fits
end
#List of all words acceptable to each guess
acceptable_words = []
#List of intersecting acceptable words (i.e. those that appear for each guess)
final_words = []
#Handles input
puts("Enter your input: ")
input = gets.strip.downcase
#splits input into list of individual guesses
input_word_list = input.downcase.split(", ")
#loops through guesses
for s in input_word_list
  #analyzes characters and positions
  zero_chars = find_zeros(s)
  one_chars = find_ones(s)
  two_chars = find_twos(s)
  #adds guesses to incorrect guess list
  incorrect_word = []

    if two_chars.size<5
      incorrect_word.push(s)
    end
  #Checks each word in the file to see if it fits with the guess
    File.open("fives.txt", "r") do |file|
        file.each_line do |line|
            if !incorrect_word.include?(line) && compare_zeros(line, zero_chars, one_chars, two_chars) && compare_ones(line, one_chars) && compare_twos(line, two_chars)
                acceptable_words.push(line)
            end
        end
    end
end
#hash to find intersecting guesses
my_hash = Hash.new
for s in acceptable_words
    if my_hash.include?(s)
        my_hash[s] = my_hash[s] + 1
    else
        my_hash[s] = 1
    end
end
#actually finding intersecting guesses
my_hash.each do |key, value|
        if value == input_word_list.size
          final_words.push(key)
        end
    end
#Prints final guess list
    puts(final_words)

=begin
Today's wordle(spoilers!!)
Enter your input:
arise01100, prion01111
intro
nitro

Test case that didn't work in original iteration
Enter your input:
least01200, grave10202, agape01202
image

Enter your input:
arise01020, horsy02120
roost
roust

Enter your input:
arise12000, grant22200, graph22200
graal
grama
gravy
=end





