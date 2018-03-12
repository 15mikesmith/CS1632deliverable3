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

def splitBlock(text, blockNum)
  newblock = text[blockNum].split(/[|:]/)
end

#split each Address into its sender and receiver components

def splitAddress(address)
  newAddress = address.join(",").split(/[>]/)
end


# Boolean methods to verify different aspects of the block are valid

#Verify Addresses are no more than 6 characters long
def invalidAddress(text)
  block0 = splitBlock(text,0)
  #Remove first 2 elements
  onlyAddresses = block0.drop(2)

  #Remove last 2 elements
  onlyAddresses = onlyAddresses.reverse.drop(2).reverse

  #Split via > Symbol
  newAddress = splitAddress(onlyAddresses)

  #Verify that each adress is 6 charcaters or less and is not numeric
  for i in newAddress

  i = i.gsub(/\(.*?\)/, '')

  if i.length > 6
      return false
    end

    if i.is_a?(Numeric)
      return false
    end
  end
  return true
end


def blockZero(text)
  block0 = splitBlock(text, 0)
  return block0.length > 4
end

def atLeastOneTransaction(text)
  return text.length > 0
end


def split_line line, num
  new_line = line[num].split(/[|]/)
end


#Verify transactions increment correctly
def incrementCorrectly(block)
  count = 0
  for i in block
    if (!count.to_s == i[0].to_s)
      return false
    end
    count += 1
  end
  return true
end


# method to convert each string to its hash
def string_to_hash arg
  return string_to_hash.unpack('U* #{arg}')
end


# method to check the generated hash
def check_hash
  val = generate_hash
end


def generate_hash
  val = split_line(text, i)
  curr_hash = val[1]
  transactions = val[2]
  timestamp = val[3]
  old_hash = val[4]
  hash_val = string_to_hash(curr_hash) + string_to_hash(transactions) + string_to_hash(timestamp) + string_to_hash(old_hash)
end

#TEST METHODS
#printBlockChain(text)
#puts(' Result of incrementCorrectly is: ', incrementCorrectly(text))
puts(splitBlock(text,0))
#split_line(text, 2)
#puts()
#puts(atLeastOneTransaction(text))
#puts()
#puts(blockZero(text))
puts()
puts(invalidAddress(text))


#end