require 'minitest/autorun'
require_relative './verifier_class'
class PrintBlockChain_test < Minitest::Test

  #Test to see whether printBlockChain outputs given a text file
  # If a value is valid then the output of the method should not be nil
  def setup
    @ver = Verifier::new 
  end

  def test_output
    text = []
    File.open("sample.txt", "r") do |f|
      f.each_line do |line|
        text << line
      end
    end
    refute_nil @ver.printBlockChain(text)
  end


end