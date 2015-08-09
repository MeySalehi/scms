class User < ActiveRecord::Base

	has_secure_password

	has_many 	:posts
	has_many	:comments

	scope :list, lambda { |page, limit| where(profile_visible: nil).order("full_name asc").last((limit * page)).first(limit).reverse}


	scope :user_posts, lambda { |user_id| where(id: user_id).first.posts}

end
