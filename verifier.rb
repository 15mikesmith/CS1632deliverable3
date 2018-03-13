#class Verifier

#The program shall accept one argument, which is the name of a file which should contain a valid Billcoin blockchain

#Array to hold text. Structure is: Each index corresponds to a line in the file

#raise "Enter a file to be verified" unless ARGV.count == 1 #verifies that an argument has been passed in
input_file = "sample.txt"
#input_file = ARGV[0]
text = []
@last_hash = 0 # a global variable to hold the last hash to compare to the hash generated
@line_count = 0
@last_timestamp = 0
@users = []

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

#Given a list of transactions, split each Address into its sender and receiver components
def splitAddress(address)
  newAddress = address.join(",")
  newAddress = newAddress.split(/[,>]/)
end

def has_digits?(str)
  str.count("0-9") > 0
end

# Boolean methods to verify different aspects of the block are valid

def timeIncreaseCorrectly(text)

#Array to hold times of all the blocks
  times = []

  #Get time from each block
  x = 0
  while x < text.length
    currBlock = splitBlock(text, x)
    times << currBlock[currBlock.length - 2]
    x += 1
  end
 # puts(times)

  #Verify the previous time is less than the current time

  y = 1
  while(y < times.length)
    #puts(times[y])
    #puts(times[y-1])
    if (times[y] < times[y-1])

      return false
    end
    y+=1
  end
  return true
end

#Verify that the last transaction in the blockchain is from SYSTEM

def lastTransactionFromSystem(text)

  x = 0
  while x < text.length

    block = splitBlock(text, x)

    #Remove first 2 elements
    onlyAddresses = block.drop(2)

    #Remove last 2 elements
    onlyAddresses = onlyAddresses.reverse.drop(2).reverse

    #puts(onlyAddresses)

    #Split via > Symbol
    newAddress = splitAddress(onlyAddresses)

    #puts(newAddress)

    #Remove billcoins from addresses
    z = 0
    while z < newAddress.length
      newAddress[z] = newAddress[z].gsub(/\(.*?\)/, '')
      z += 1
    end

    #puts(newAddress[-2])

    if !(newAddress[-2] == "SYSTEM")
      return false
    end

    x += 1
  end

  return true
end


def atLeastOneTransaction(text)
  x = 0
  while x < text.length
    block = splitBlock(text, x)
    #Remove first 2 elements
    onlyAddresses = block.drop(2)

    #Remove last 2 elements
    onlyAddresses = onlyAddresses.reverse.drop(2).reverse

    if onlyAddresses.length == 0
      return false
    end

    x += 1
  end
  return true
end


#Verify Addresses are no more than 6 characters long
def validAddress(text)

  x = 0
  while x < text.length

    block = splitBlock(text, x)

    #Remove first 2 elements
    onlyAddresses = block.drop(2)

    #Remove last 2 elements
    onlyAddresses = onlyAddresses.reverse.drop(2).reverse

    #puts(onlyAddresses)

    #Split via > Symbol
    newAddress = splitAddress(onlyAddresses)

    #puts(newAddress)

    #Remove billcoins from addresses
    z = 0
    while z < newAddress.length
      newAddress[z] = newAddress[z].gsub(/\(.*?\)/, '')
      z += 1
    end


    #Verify that each adress is 6 charcaters or less and is not numeric
    for i in newAddress

      if i.length > 6
        return false
      end

      if has_digits?(i)#i.is_a?(Numeric)
        return false
      end
    end
    x += 1
  end
  return true
end

#Verify Block 0 has only 1 transaction
def blockZero(text)
  block0 = splitBlock(text, 0)
  return block0.length == 5
end

#Verify there is at least 1 block in the blockchain
def atLeastOneBlock(text)
  return text.length > 0
end


def split_line line, num
  new_line = line[num].split(/[|]/)
end


#Verify transactions increment correctly
def incrementCorrectly(block)
  count = 0
  for i in block
    if !(count.to_s == i[0].to_s)
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
def check_hash text
  var_array = create_var text
  val = generate_hash var_array
  raise "Hashes do not match" unless val == @last_hash
end

def create_var text
  split_val = split_line(text, @line_count)
  curr_hash = split_val[1]
  transactions = split_val[2]
  timestamp = split_val[3]
  old_hash = split_val[4]
  return split_val
end


def generate_hash val
  for i in 1...5
    hash_val = hash_val + val[i].encode!('UTF-16', 'UTF-8')
  end
  @last_hash = val[@line_count]
  # hash_val = string_to_hash(curr_hash) + string_to_hash(transactions) + string_to_hash(timestamp) + string_to_hash(old_hash)
end

def check_timestamp text
  while @line_count < 5
    split_val = split_line(text, @line_count)
    timestamp = split_val[3].to_f
    #puts("TIMESTAMP: #{timestamp} & LINECOUNT = #{@line_count}")
    raise "Timestamp incorrect" unless timestamp >= @last_timestamp
    @last_timestamp = timestamp
    @line_count += 1

  end
end


def users text
  transactions = create_var text
  string = transactions[2].split(/:/)
  for i in 0...string.length
    users = string[i].split(/>()/)
    puts "1 #{users[0]} 2 #{users[2]}"
  end
end


def check_name giver, receiver, amount
  giver_exists = false
  receiver_exists = false
  @names.each {|x|
    if giver == x
      giver.coins -= amount
      giver_exists = true
    end
    if receiver == x
      receiver.coins += amount
      receiver_exists = true
    end
  }
=begin
  if(!giver_exists)
    giv = Users::new giv, amount
    @names << giv
  end

  if(!receiver_exists)
    rec = Users::new receiver, amount
    @names << rec
  end
=end
end

#TEST METHODS

#printBlockChain(text)
#puts(' Result of incrementCorrectly is: ', incrementCorrectly(text))
#puts(splitBlock(text,0))
#check_hash text
#check_timestamp text
#users text
#check_name 'Bill', 'Gina', 500

#split_line(text, 2)
#puts()
#puts(atLeastOneBlock(text))
#puts()
#puts(blockZero(text))
#puts()
#puts(validAddress(text))
#puts()
#puts(atLeastOneTransaction(text))
#puts()
#puts(lastTransactionFromSystem(text))
puts()
puts(timeIncreaseCorrectly(text))

#end