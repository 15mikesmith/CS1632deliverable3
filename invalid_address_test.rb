  require 'minitest/autorun'
  require_relative './verifier'
  class ValidAddress_test < Minitest::Test

    #Test to see whether the last transaction in each block is from SYSTEM
    def test_valid_address
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      assert_equal true , validAddress(text)

    end

    def test_address_numeric
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      text[0] ="0|0|SYSTEM>He6ry(100)|1518892051.737141000|1c12"
      assert_equal false , validAddress(text)
    end
    def test_address_too_long
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      text[0] ="0|0|SYSTEM>Henryyy(100)|1518892051.737141000|1c12"
      assert_equal false , validAddress(text)
    end

  end