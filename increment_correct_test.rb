  require 'minitest/autorun'
  require_relative './verifier'
  class IncrementCorrect_test < Minitest::Test

    #Test to see whether block 0 only contains 1 transaction
    def test_block_zero_valid
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      assert_equal true , incrementCorrectly(text)

    end

    def test_block_zero_invalid
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      text[0] = "1|0|SYSTEM>Henry(100)|1518892051.737141000|1c12"
      text[1] = "0|1c12|SYSTEM>George(100)|1518892051.740967000|abb2"
      puts(text)
      assert_equal false , incrementCorrectly(text)
    end

  end