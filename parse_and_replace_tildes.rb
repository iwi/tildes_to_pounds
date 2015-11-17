#!/usr/bin/env ruby
#
# This process will parse the input file and execute two actions:
# - It will change the nth tilde to a pound sign for lines starting with
#   a 3 which have at least 21 tildes in total.
#
# - For lines starting with 7 if the number of original tildes is N it will
#   substitute the 2nd to the N-2th with spaces.
#
# This script assumes the input file is encoded as CP850,
# the output is utf-8.


##
# Inspired on the standard String#tr http://ruby-doc.org/core-2.2.0/String.html#method-i-tr
# but using explicit input instead of extending/refining String.
#
# @param String input
# @param Integer nth The occurrence to replace
# @param String from_str The string to capture
# @param String to_str The string to replace captures with
#
# @return String
def tr_nth(input, nth, from_str, to_str)
  input.gsub(/#{from_str}/).with_index { |char, i| i == nth ? to_str : char }
end

##
# Recursive function to convert several from_str to to_str
#
# @param String input
# @param Integer nth The occurrence to replace
# @param String from_str The string to capture
# @param String to_str The string to replace captures with
#
# @return String
def tr_many(input, nth, from_str, to_str)
  new_input = tr_nth(input, nth, from_str, to_str)

  return new_input if new_input.count(from_str) <= 3

  tr_many(new_input, nth, from_str, to_str)
end

##
# Asks for input
def ask(str)
  puts str
  gets.chomp
end

# Message on encodings:
puts "-------------------------------------------------------------------------"
puts "This process will parse the input file and execute two actions:"
puts "- It will change the nth tilde to a pound sign for lines starting with"
puts "  a 3 which have at least 21 tildes in total."
puts "- For lines starting with 7 if the number of original tildes is N it will"
puts "  substitute the 2nd to the N-2th with spaces"
puts
puts "This script assumes the input file is encoded as CP850 and output UTF-8."
puts "-------------------------------------------------------------------------"


# Capturing the inputs
filename = ask("Enter the filename")
input = File.open(filename, 'r:CP850:utf-8')

nth = ask("Enter the n for the n-th tilde that will be replaced to a pound symbol:")
nth_pounds = Integer(nth) - 1

# This is a constant but if necessary could become a variable
nth_cond_caution = 2 - 1

new_file = ask("Do you want to create a new file? (Y/N) Otherwise print to stdout")
new_file = new_file.upcase == 'Y'

puts "Opening... ", filename

# Make the substitutions
output = input.readlines.map do |line|
  puts "Replacing characters..."
  if line.start_with?('7') && line.count('~') > 3
    tr_many(line, nth_cond_caution, '~', ' ')
  elsif line.start_with?('3') && line.count('~') > 20
    tr_nth(line, nth_pounds, '~', '£')
  else
    line
  end
end


if new_file
  puts "Writing output to edited_#{filename} ..."
  File.open("edited_#{filename}", 'w:utf-8') { |io| io.puts output }
else
  puts output
end
