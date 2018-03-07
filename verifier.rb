#class Verifier

#The program shall accept one argument, which is the name of a file which should contain a valid Billcoin blockchain

#Array to hold text. Structure is: Each index corresponds to a line in the file

raise "Enter a file to be verified" unless ARGV.count == 1 #verifies that an argument has been passed in
input_file = ARGV[0]
text = []



#Read text file
#Eventually need to change to accept an input argument instead of hardcoded filename
raise "Please enter a valid file" unless File.file?(input_file) #verifies that input file is a file
File.open(input_file, "r") do |f|
  f.each_line do |line|
    text << line
    # puts line
  end
end


  #print out the Blockchain into each block

  def printBlockChain(text)
    for i in text
      puts(i)
    end
  end


  #split each block into seperate components

  def splitBlock(block,blockNum)
    newblock = block[blockNum].split(/[|:]/)
    #newblock = newblock.split(':')
  end


  # Boolean methods to verify different aspects of the block are valid

  def atLeastOneTransaction(text)
      return text.length > 0
  end



  def split_line line, num
    new_line = line[num].split(/[|]/)
  end



  #Increment correctly method
  def incrementCorrectly(block)
    count = 0
   for i in block
     if(!count.to_s == i[0].to_s)
       return false
    end
    count+=1
   end
    return true
  end



  # method to convert each string to its hash
  def string_to_hash arg 
    return string_to_hash.unpack('U* #{arg}')
  end



  # method to check the hash
  def check_hash
    arg_val = 4
    for i in 1...arg_val do
      val = split_line(text, i)
      curr_hash = val[1]
      transactions = val[2]
      timestamp = val[3]
      old_hash = val[4]
    end
  end



  #TEST METHODS
  #printBlockChain(text)
  #puts(' Result of incrementCorrectly is: ', incrementCorrectly(text))
  #puts(splitBlock(text,1))
  split_line(text, 2))
  puts()
  puts(atLeastOneTransaction(text))


#end