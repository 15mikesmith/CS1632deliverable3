#class Verifier

  #The program shall accept one argument, which is the name of a file which should contain a valid Billcoin blockchain

  #Array to hold text. Structure is: Each index corresponds to a line in the file

  raise "Enter a seed and only a seed" unless ARGV.count == 1
  input_file = ARGV[0]
  puts input_file
  text = []


  #Read text file
  #Eventually need to change to accept an input argument instead of hardcoded filename
  File.open(input_file, "r") do |f|
    f.each_line do |line|
      text << line
     # puts line
    end
  end

  #print out the Block

  def printBlock(text)
    for i in text
      puts(i)
    end
   end

  # Boolean methods to verify different aspects of the block are valid




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


  printBlock(text)
  puts()
  puts(' Result of incrementCorrectly is: ', incrementCorrectly(text))



#end