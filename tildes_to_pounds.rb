#!/usr/bin/env ruby
#
# For a given text file, this script substitutes the nth tilde ("~") in each
# line starting with a "3" with a pound symbol ("£").
#
# Fix from Iu Garcia-Siches 2015-10-09

# Capturing the inputs
puts "Enter the filename"
filename = gets.chomp
puts "Enter the Nth tilde:"
nth_tilde = gets.chomp.to_i - 1
puts "Do you want to create a new file? (Y/N) (Otherwise just lists occurences)"
new_file = gets.chomp.upcase

# Open the output file if needed
fileOut = File.open("edited_" + filename, 'w') if new_file == 'Y'

# Iterate through the lines of the file and through the tildes of each line
File.foreach(filename) do |line|
  if line[0] == "3"
    line.gsub!(/~/).each_with_index do |tildes, index|
      if index == nth_tilde
        tildes = "£"
      else
        tildes
      end
    end
  end
  fileOut.write(line) if new_file == 'Y'
end
