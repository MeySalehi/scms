class Post < ActiveRecord::Base

	belongs_to 	:user
	has_many	:comments
	has_and_belongs_to_many :categories, :join_table => :posts_categories


	#-----------------------------Scopes--------------------------------
	scope :post_by_permalink, lambda { |permalink|
					where(permalink: permalink, type_set: "POST" ).first}
	
	scope :page_by_permalink, lambda { |permalink|
					where(permalink: permalink, type_set: "PAGE" ).first}
	
	scope :public_recent_post, lambda { |limit|
					where(status: "PUBLIC", type_set: "POST")
						.last(limit).reverse }
	
	scope :users_recent_post, lambda { |limit|
					where(status: ["PUBLIC", "USERS"], type_set: "POST")
						.last(limit).reverse }

	scope :search, lambda { |query|
					where(["title LIKE ?", "%#{query}%" ]) }
	
	scope :page_public,	lambda { |page, limit|
					where(status: "PUBLIC", type_set: "POST")
						.order(publish_at: :desc).limit(limit).offset((limit * page) - limit)}
	
	scope :page_users, lambda { |page, limit|
					where(status: [ "USERS", "PUBLIC"], type_set: "POST")
						.order(publish_at: :desc).limit(limit).offset((limit * page) - limit)}
	
	scope :pages_count,	lambda { where(type_set: "PAGE").count }
	
	scope :posts_count, lambda { where(type_set: "POST").count }
	
	scope :search_for_public, lambda { |title, page, limit|
					where("title LIKE? '%#{title}%'", status: "PUBLIC")
						.order(publish_at: :desc).limit(limit).offset((limit * page) - limit)}
	
	scope :search_for_users, lambda { |title, page, limit|
					where(title: title, status: [ "USERS", "PUBLIC"])
						.order(publish_at: :desc).limit(limit).offset((limit * page) - limit)}
	
	scope :users_post_count, lambda { where(type_set: "POST", status: ["PUBLIC", "USERS"]).count }
	
	scope :public_post_count, lambda { where(type_set: "POST", status: "PUBLIC").count }

	#----------------------------------------------

	scope :user_posts, lambda { |user_id, page, limit, type_set| 
					where(user_id: user_id, type_set: type_set)
						.order(created_at: :desc).limit(limit).offset((limit * page) - limit)}
	scope :user_posts_count, lambda { |user_id, type_set| where(user_id: user_id, type_set: type_set).count}
end
