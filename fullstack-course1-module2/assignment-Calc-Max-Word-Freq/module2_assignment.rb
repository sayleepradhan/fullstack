#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result
  

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.
  def initialize(line, line_number)
	@content = line
	@line_number = line_number
	calculate_word_frequency()
  end
  
 
  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency()
	word_frequency = Hash.new(0)
	@highest_wf_count = 0
	@highest_wf_words = []
	
	@content.split.each do |word|
		word_frequency[word.downcase] += 1	
	end
	
	@content.split.each do |word|
		if word_frequency[word.downcase] > @highest_wf_count
			@highest_wf_count = word_frequency[word.downcase]
		end
	end
	
	@content.split.each do |word|
		if word_frequency[word.downcase] == @highest_wf_count and @highest_wf_words.index(word.downcase)==nil
			@highest_wf_words << word.downcase;
		end
	end
  end

end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #  equal to the highest_count_across_lines determined previously.
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
  
  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format
  def initialize()
	@analyzers = []
	
  end
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file
  def analyze_file()
	number = 0
	File.foreach('test.txt') do |line|
		number += 1
		@analyzers << LineAnalyzer.new(line.chomp,number);
	end
	return @analyzers
  end
  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.

  def calculate_line_with_highest_frequency()
	@highest_count_across_lines = 0
	@highest_count_words_across_lines = []
	
	@analyzers.each do |line|
		if line.highest_wf_count > @highest_count_across_lines
			@highest_count_across_lines=line.highest_wf_count
		end
	end
	
	@analyzers.each do |line|
		if @highest_count_across_lines == line.highest_wf_count
			@highest_count_words_across_lines << line
		end
	end
	@highest_count_words_across_lines.uniq!
  end
  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines()
	coll = []
	puts "The following words have the highest word frequency per line:"
	@highest_count_words_across_lines.each do |line_analyzer|
		puts "["
		line_analyzer.highest_wf_words.each do |word|
			puts "\""+word+"\","
			coll << word
		end
		puts "] (appears in line #{line_analyzer.line_number})\n"
	end
	return coll
  end
end
