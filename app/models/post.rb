class Post < ActiveRecord::Base

	belongs_to 	:user
	has_many	:comments
	has_and_belongs_to_many :categories, :join_table => :posts_categories

	scope :post_by_permalink, lambda {|permalink| where(permalink: permalink, type: "POST" ).first}
	scope :page_by_permalink, lambda {|permalink| where(permalink: permalink, type: "PAGE" ).first}
	scope :recent_post,		lambda { |num| last(num).reverse }
	scope :search,			lambda { |query| where(["title LIKE ?", "%#{query}%" ]) }
	scope :page,			lambda { |page, limit| limit(limit).last((limit * page)).first(limit).reverse}
	scope :page_count,		lambda { where(:type, "PAGE").count }
	scope :post_count,		lambda { where(:type, "POST").count }
end
