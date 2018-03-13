  require 'minitest/autorun'
  require_relative './verifier'
  class AtLeastOneBlock_test < Minitest::Test

    #Test to see whether block 0 only contains 1 transaction
    def test_block_zero_valid
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      assert_equal true , atLeastOneBlock(text)

    end

    def test_block_zero_invalid
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      text = ""
      assert_equal false , atLeastOneBlock(text)
    end

  end