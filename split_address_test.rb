require 'minitest/autorun'
require_relative './verifier'
class SplitAddress_test < Minitest::Test

  #Test to see whether splitBock method splits a given block correctly into seperate components

  def test_split_address_firstT_correctly
    text = []
    File.open("sample.txt", "r") do |f|
      f.each_line do |line|
        text << line
      end
    end
    block = splitBlock(text, 0)

    #Remove first 2 elements
    onlyAddresses = block.drop(2)

    #Remove last 2 elements
    onlyAddresses = onlyAddresses.reverse.drop(2).reverse

    #puts(onlyAddresses)

    #Split via > Symbol
    newAddress = splitAddress(onlyAddresses)

    assert_equal ["SYSTEM","Henry(100)"], newAddress
  end

  def test_split_address_lastT_correctly
    text = []
    File.open("sample.txt", "r") do |f|
      f.each_line do |line|
        text << line
      end
    end
    block = splitBlock(text, 9)

    #Remove first 2 elements
    onlyAddresses = block.drop(2)

    #Remove last 2 elements
    onlyAddresses = onlyAddresses.reverse.drop(2).reverse

    #puts(onlyAddresses)

    #Split via > Symbol
    newAddress = splitAddress(onlyAddresses)

    assert_equal ["Henry","Pakal(10)","SYSTEM","Amina(100)"], newAddress
  end



end