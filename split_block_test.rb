  require 'minitest/autorun'
  require_relative './verifier'
  class SplitBlock_test < Minitest::Test

    #Test to see whether splitBock method splits a given block correctly into seperate components

    def test_split_correctly
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      test = splitBlock(text, 0)

      assert_equal 5, test.length
    end


  end