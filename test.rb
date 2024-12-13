def find_zeros(input_word)
    zeros = []
    (0..5).each do |i|
        zeros << input_word[i] if input_word[i + 5] == '0'
    end
    zeros
end

def find_ones(input_word)
    ones = []
    (0..5).each do |i|
        if input_word[i + 5] == '1'
            ones << input_word[i]
            ones << i
        end
    end
    ones
end

def find_twos(input_word)
    twos = []
    (0..5).each do |i|
        if input_word[i + 5] == '2'
            twos << input_word[i]
            twos << i
        end
    end
    twos
end

def compare_zeros(analysis_word, zero_chars, one_chars, two_chars)
    zero_chars.none? { |c| analysis_word.include?(c) && !one_chars.include?(c) && !two_chars.include?(c) }
end

def compare_ones(analysis_word, one_chars)
    one_chars.each_slice(2).all? do |char, index|
        analysis_word[index] == char
    end
end

def compare_twos(analysis_word, two_chars)
    two_chars.each_slice(2).all? do |char, index|
        analysis_word[index] == char
    end
end

acceptable_words = []
final_words = []

puts "Enter your input: "
input = gets.chomp
input_word_list = input.downcase.split(", ")

all_words = File.readlines("fives.txt").map(&:chomp)

input_word_list.each do |s|
    zero_chars = find_zeros(s)
    one_chars = find_ones(s)
    two_chars = find_twos(s)

    if two_chars.size < 10
        next
    end

    acceptable_words = all_words.select do |line|
        compare_zeros(line, zero_chars, one_chars, two_chars) &&
        compare_ones(line, one_chars) &&
        compare_twos(line, two_chars)
    end
end

word_count = acceptable_words.each_with_object(Hash.new(0)) { |word, count| count[word] += 1 }

word_count.each do |word, count|
    final_words << word if count == input_word_list.size
end

puts final_words