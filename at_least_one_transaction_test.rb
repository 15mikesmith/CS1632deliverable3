  require 'minitest/autorun'
  require_relative './verifier_class'
  class AtLeastOneTransaction_test < Minitest::Test

  def setup
    @ver = Verifier::new 
  end
    #Test to see whether the last transaction in each block is from SYSTEM
    def test_one_transaction
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      assert_equal true , @ver.atLeastOneTransaction(text)

    end

    def test_zero_transaction
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      text = text[0]="0|0|1518892051.737141000|1c12"
      assert_equal false , @ver.atLeastOneTransaction(text)
    end

  end