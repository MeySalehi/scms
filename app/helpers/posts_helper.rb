module PostsHelper
	def comments_tree_for(comments)
		comments.map do |comment|
			nested_comments = Comment.childs(comment.id)
			render(partial: "posts/comment", object: comment) +
        (nested_comments.size > 0 ? content_tag(:div, comments_tree_for(nested_comments), class: 'replies') : nil)
		end.join.html_safe
	end
end
