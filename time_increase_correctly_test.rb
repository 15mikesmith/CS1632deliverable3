  require 'minitest/autorun'
  require_relative './verifier'
  class TimeIncreaseCorrectly_test < Minitest::Test

    #Test to see whether timeIncreaseCorrectly method returns true when time stamps are increasing and false when decreasing
    def test_time_increasing
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      assert_equal true , timeIncreaseCorrectly(text)

    end

    def test_time_decreasing
      text = []
      File.open("sample.txt", "r") do |f|
        f.each_line do |line|
          text << line
        end
      end
      text = text.reverse
      assert_equal false , timeIncreaseCorrectly(text)
    end

  end