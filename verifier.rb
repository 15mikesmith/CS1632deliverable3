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

  def splitBlock(text,blockNum)
    newblock = text[blockNum].split(/[|:]/)
  end

  # Boolean methods to verify different aspects of the block are valid

    def blockZero(text)
      block0 = splitBlock(text,0)

      return block0.length > 4
    end

    def atLeastOneTransaction(text)
      return text.length > 0
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



  #TEST METHODS
  printBlockChain(text)
  puts()
  #puts(' Result of incrementCorrectly is: ', incrementCorrectly(text))
  puts(splitBlock(text,2))
  puts()
  puts(atLeastOneTransaction(text))
  puts()
  puts(blockZero(text))


#end