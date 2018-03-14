require_relative 'users'
#require 'flamegraph'


#class Verifier
#The program shall accept one argument, which is the name of a file which should contain a valid Billcoin blockchain

doc = []

File.open("100.txt", "r") do |f|
  f.each_line do |line|
    doc << line
    # puts line
  end
end

  def initialize
    @last_hash = 0 # a global variable to hold the last hash to compare to the hash generated
    @line_count = 0
    @last_timestamp = 0
    @users = []
    @text = []
  end


  def run file
    Flamegraph.generate('flamegrapher.html') do
      open_file file, @text
      if(!timeIncreaseCorrectly @text)
        exit(1)
      end
      if(!check_hash @text)
        exit(1)
      end
      if(!incrementCorrectly @text)
        exit(1)
      end
      if(!atLeastOneBlock @text)
        exit(1)
      end
      if(!blockZero @text)
        exit(1)
      end
      if(!validAddress @text)
        exit(1)
      end
      if(!atLeastOneTransaction @text)
        exit(1)
      end
      if(!lastTransactionFromSystem @text)
        exit(1)
      end
      users_run @text
      print_users
      #puts(timeIncreaseCorrectly(text))
    end
  end

  def open_file file, text
    File.open(file, "r") do |f|
      f.each_line do |line|
        text << line
        # puts line
      end
    end
  end

#raise "Enter a file to be verified" unless ARGV.count == 1 #verifies that an argument has been passed in
#Read text file


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
  def getFifth(text, block)
    result = splitBlock(text, block)
    fifth = result.pop()
  end

  def verifyHashForBlock(text, block)

    b = text[block]
    fifth = getFifth(text, block) #block[block.length-5...block.length-1]
    fifth = fifth.gsub("\n", '')

    if (fifth.length == 4)
      word = b[0...b.length - 6]
    elsif (fifth.length == 3)
      word = b[0...b.length - 5]
    elsif (fifth.length == 2)
      word = b[0...b.length - 4]
    else
      word = b[0...b.length - 3]
    end

    word = word.unpack('U*')

    sum = 0
    x = 0

    while x < word.length
      z = word[x]

      result = (z ** 2000) * ((z + 2) ** 21) - ((z + 5) ** 3)
      sum += result

      x += 1
    end

    answer = sum % 65536


    answer2 = answer.to_s(16)
   # puts(answer2)
   # puts(fifth)

    s = answer2.encode("UTF-8")

    if (s.eql? fifth)
      return true
    else
      puts "HASH ERROR: at line #{block} \nHash #{s} should be #{fifth}"
      return false
    end
  end


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
  #puts(times)

  #Verify the previous time is less than the current time

  y = 1
  while (y < times.length)
    #puts(times[y])
    #puts(times[y-1])
    if (times[y].to_i < times[y - 1].to_i)
      #puts(times[y])
      #puts(times[y - 1])
      puts "TIMESTAMP ERROR: at line #{y} #{times[y].to_i} < #{times[y - 1].to_i}"
      return false
    end
    y += 1
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
      puts "AT LEAST ONE TRANSACTION ERROR: at line #{x}"
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

      if has_digits?(i) #i.is_a?(Numeric)
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
      puts "ERROR"
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
  i = 0
  var = true
  while i < text.length
    var = verifyHashForBlock text, i
    if(!var)
      exit(1)
    end
    i += 1
  end
  return var
end

  
  def users text
    users = text.split(/[()>:]/)
    return users
  end


  def billcoin_handler_giver giver, amount
    ret = false
    @users.each {|x|
      if giver == x.name
        x.coins -= amount
        ret = true
      end
    }
    return ret
  end

  def billcoin_handler_receiver receiver, amount
    @users.each {|x|
      if receiver == x.name
        x.coins += amount
      end
    }
  end

  def search_users array, user
    var = false
    array.each {|x|
      if user == x.name
        var = true
      end
    }
    return var

  end

  def add_user user, type, amount
    if (Float(user) != nil rescue false)
      return
    end
    if user.to_s.empty?
      return
    end
    if (type == 0)
      giv = Users::new user, 0
      @users << giv
    end

    if (type == 1)
      rec = Users::new user, amount
      @users << rec
    end
  end

  def print_users
    @users.each {|x|
      if x.name != "SYSTEM" && x.coins > 0
        puts "#{x.name}: #{x.coins} billcoins"
      end
    }
  end


  def users_run text
    x = 0
    i = 0
    info = []
    while x < text.length
      curr_text = split_line(text, x)
      info = users curr_text[2]
      i = 0


      for i in 0...info.length
        giv = i
        rec = i + 1
        amount = i + 2

        if (search_users @users, info[i])
          billcoin_handler_giver info[giv], info[amount].to_i
        else
          add_user info[giv], 0, info[amount].to_i
        end

        if (search_users @users, info[rec])
          billcoin_handler_receiver info[rec], info[amount].to_i
        else
          add_user info[rec], 1, info[amount].to_i
        end
        i += 3
      end
      x += 1
    end
  end

puts(incrementCorrectly(doc))

#end
