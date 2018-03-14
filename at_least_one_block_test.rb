  require 'minitest/autorun'
  require_relative './verifier_class'
  class AtLeastOneBlock_test < Minitest::Test

  def setup
    @ver = Verifier::new 
  end

    #Test to see whether block 0 only contains 1 transaction
    def test_block_zero_valid
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      assert_equal true , @ver.atLeastOneBlock(text)

    end

    def test_block_zero_invalid
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      text = ""
      assert_equal false , @ver.atLeastOneBlock(text)
    end

  end