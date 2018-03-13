require 'minitest/autorun'
require_relative './verifier'
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
		giv = Users::new 'Phil', 200
		rec = Users::new 'Jo', 100
		array = []
		array << giv
		array << rec
		val = verifier.search_users array, giv.name, rec.name, 50
		assert_equal val[0], true 
		assert_equal val[1], true
	end

	def test_print_users
	end


end