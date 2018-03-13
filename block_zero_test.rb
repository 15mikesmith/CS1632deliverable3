  require 'minitest/autorun'
  require_relative './verifier'
  class BlockZero_test < Minitest::Test

    #Test to see whether block 0 only contains 1 transaction
    def test_block_zero_valid
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      assert_equal true , blockZero(text)

    end

    def test_block_zero_invalid
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      text[0]="0|0||George>Amina(16):Henry>James(4)|1518892051.737141000|1c12"
      assert_equal false , blockZero(text)
    end

  end