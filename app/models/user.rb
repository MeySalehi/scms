class User < ActiveRecord::Base

	has_secure_password

	has_many 	:posts
	has_many	:comments

	scope :list, lambda { |page, limit| where(profile_visible: true).order(:full_name).limit(limit).offset((limit * (page -1)))}


	scope :user_posts, lambda { |user_id| where(id: user_id).first.posts}

	scope :users_list, lambda { |page, limit| order(full_name: :desc).limit(limit).offset((limit * (page - 1)))}
end
