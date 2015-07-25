class CreatePosts < ActiveRecord::Migration

  def up
    create_table :posts do |t|
    	t.integer		:author_id
    	t.string		:title, 					null: false
    	t.string		:status, 					null: false
    	t.string		:comment_status
    	t.datetime	:publish_at
    	t.string		:password_digest
    	t.integer		:commnet_count
    	t.text			:content
    	t.integer		:tag_id
    	t.string		:permalink

      t.timestamps 									null: false
    end
    add_index(:posts, :author_id)
  end

  def down
  	drop_table :posts
  end

end
