class Verifier

  #The program shall accept one argument, which is the name of a file which should contain a valid Billcoin blockchain

  #Array to hold text. Structure is: Each index corresponds to a line in the file
  text = []

  #Read text file
  #Eventually need to change to accept an input argument instead of hardcoded filename
  File.open("sample.txt", "r") do |f|
    f.each_line do |line|
      text << line
     # puts line
    end
  end

  #print out text
  for i in text
    puts(i)
  end

  # Boolean methods to verify different aspects of the block are valid

end