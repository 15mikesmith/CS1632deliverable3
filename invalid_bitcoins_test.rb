require 'minitest/autorun'
require_relative './verifier_class'
require_relative 'users'

class Users_test < Minitest::Test
	def setup
		@user = Users::new 'Phil', 200
		@verifier = Verifier::new 
	end

	def test_invalid_coins
		phil = Users::new 'Phil', -200
		array = []
		array << phil
		val = @verifier.check_bitcoins array
		assert_equal val, false
	end



end