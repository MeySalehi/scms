class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	scope :post_comments, lambda { |post_id, page, limit| where(post_id: post_id)
						.order(created_at: :desc).limit(limit).offset((limit * (page - 1)))}
	scope :user_posts_comments, lambda { |post_ids, page, limit|  where(post_id: post_ids)
						.order(created_at: :desc).limit(limit).offset((limit * (page - 1)))}

	scope :post_comments_count, lambda{ |post_id| where(post_id: post_id).count}

	scope :user_posts_comments_count, lambda{ |post_ids|  where(post_id: post_ids).count }

	scope :childs, lambda{ |comment_id| where(parent_id: comment_id, approved: "PUBLIC").order(created_at: :asc)}
	scope :parent_comments, lambda{|post_id| where(post_id: post_id ,parent_id: nil, approved: "PUBLIC").order(created_at: :asc) }

end
