class Post < ActiveRecord::Base

	belongs_to 	:user
	has_many	:comments
	has_and_belongs_to_many :categories, :join_table => :posts_categories

	scope :post_by_permalink, 	lambda { |permalink| where(permalink: permalink ).first}#<<<< after edit seed add the type: "POST"
	scope :page_by_permalink, 	lambda { |permalink| where(permalink: permalink ).first}#<<<< after edit seed add the type: "PAGE"
	scope :public_recent_post,	lambda { |limit| where(status: "PUBLISH").last(limit).reverse }
	scope :users_recent_post,		lambda { |limit| where(status: ["PUBLISH", "USERS"]).last(limit).reverse }
	scope :search,							lambda { |query| where(["title LIKE ?", "%#{query}%" ]) }
	scope :page_public,					lambda { |page, limit| where(status: "PUBLISH").limit(limit).last((limit * page)).first(limit).reverse}
	scope :page_users,					lambda { |page, limit| where(status: [ "USERS", "PUBLISH"]).limit(limit).last((limit * page)).first(limit).reverse}
	scope :pages_count,					lambda { where(type_set: "PAGE").count }
	scope :posts_count,					lambda { where(type_set: "POST").count }
	scope :search_for_public,		lambda { |title, page, limit| where(title: title, status: "PUBLISH").limit(limit).last((limit * page)).first(limit).reverse }
	scope :search_for_users,		lambda { |title, page, limit| where(title: title, status: [ "USERS", "PUBLISH"]).limit(limit).last((limit * page)).first(limit).reverse}
end
