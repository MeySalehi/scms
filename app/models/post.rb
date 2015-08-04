class Post < ActiveRecord::Base

	belongs_to 	:user
	has_many	:comments
	has_and_belongs_to_many :categories, :join_table => :posts_categories

	scope :recent_post, lambda { |num| last(num).reverse }
	scope :search, lambda { |query| where(["title LIKE ?", "%#{query}%" ]) }
	scope :page, lambda { |page, limit| limit(limit).last((limit * page)).first(limit).reverse} 
end
