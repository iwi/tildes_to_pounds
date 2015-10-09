#!/usr/bin/env ruby

puts "Enter the filename"
filename = gets.chomp
puts "Enter the Nth tilde:"
nth_tilde = gets.chomp.to_i - 1
# puts "Do you want to create a new file? (Y/N) (Otherwise just lists occurences)"
# new_file = gets.chomp.upcase
new_file = "Y"

fileOut = File.open("edited_" + filename, 'w') if new_file == 'Y'

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
