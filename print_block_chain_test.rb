require 'minitest/autorun'
require_relative './verifier'
class PrintBlockChain_test < Minitest::Test

  #Test to see whether printBlockChain outputs given a text file
  # If a value is valid then the output of the method should not be nil

  def test_output
    text = []
    File.open("sample.txt", "r") do |f|
      f.each_line do |line|
        text << line
      end
    end
    refute_nil printBlockChain(text)
  end


end