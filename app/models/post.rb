class Post < ActiveRecord::Base
	belongs_to 	:users
	has_many	:comments
	has_and_belongs_to_many :categories, :join_table => :posts_categories
	has_secure_password
end
