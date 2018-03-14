  require 'minitest/autorun'
  require_relative './verifier_class'
  class LastTransactionFromSystem_test < Minitest::Test

    def setup
      @ver = Verifier::new 
    end
    #Test to see whether the last transaction in each block is from SYSTEM
    def test_last_transaction_is_SYSTEM
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      assert_equal true , @ver.lastTransactionFromSystem(text)

    end

    def test_last_transaction_is_not_SYSTEM
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      text[0]="0|0|Henry>SYSTEM(100)|1518892051.737141000|1c12"
      assert_equal false , @ver.lastTransactionFromSystem(text)
    end

  end