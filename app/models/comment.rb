class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	scope :post_comments, lambda { |post_id, page, limit| where(post_id: post_id)
						.order(created_at: :desc).limit(limit).offset((limit * (page - 1)))}
	scope :user_posts_comments, lambda { |post_ids, page, limit|  where(post_id: post_ids)
						.order(created_at: :desc).limit(limit).offset((limit * (page - 1)))}

	scope :post_comments_count, lambda{ |post_id| where(post_id: post_id).count}

	scope :user_posts_comments_count, lambda{ |post_ids|  where(post_id: post_ids).count }

end
