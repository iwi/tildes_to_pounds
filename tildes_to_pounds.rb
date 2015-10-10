#!/usr/bin/env ruby
#
# For a given text file, this script substitutes the nth tilde ("~") in each
# line starting with a "3" with a pound symbol ("£").
#
# Fix from Iu Garcia-Siches 2015-10-09

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
# Asks for input
def ask(str)
  puts str
  gets.chomp
end



# Capturing the inputs
filename = ask("Enter the filename")
input = File.open(filename, 'r')

nth = ask("Enter the n for the n-th tilde that will be replaced:")
nth = Integer(nth) - 1

new_file = ask("Do you want to create a new file? (Y/N) (Otherwise just lists occurences)")
new_file = new_file.upcase == 'Y'

output = input.readlines.map do |line|
  if line.start_with?('3')
    tr_nth(line, nth, '~', '£')
  else
    line
  end
end

if new_file
  File.open("edited_#{filename}", 'w') { |io| io.puts output }
else
  puts output
end
