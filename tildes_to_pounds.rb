#!/usr/bin/env ruby
#
# For a given text file, this script substitutes the nth tilde ("~") in each
# line starting with a "3" with a pound symbol ("£").
#
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
# Note: in its actual use the process crashed because of the encoding from the
# input file which was CP850. The fix was to specify input and output encodings
# File.open(filename, 'r:CP850:utf-8')
filename = ask("Enter the filename")
input = File.open(filename, 'r')

nth = ask("Enter the n for the n-th tilde that will be replaced:")
nth = Integer(nth) - 1

new_file = ask("Do you want to create a new file? (Y/N) Otherwise print to stdout")
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
