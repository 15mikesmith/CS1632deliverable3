require 'minitest/autorun'
require_relative './verifier_class'
require_relative 'users'

class Users_test < Minitest::Test
	def setup
		@user = Users::new 'Phil', 200
		@verifier = Verifier::new 
	end

	def test_user_creation
		@user = Users::new 'Phil', 200
		assert @user.is_a?(Users)
	end

	def test_user_coins
		@user = Users::new 'Phil', 200
		assert_equal @user.coins, 200
	end

	def test_user_search
		phil = Users::new 'Phil', 200
		array = []
		array << phil
		val = @verifier.search_users array, phil.name
		assert_equal val, true 
	end



end