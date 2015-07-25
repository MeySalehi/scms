class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
    	t.integer	:post_id, 			null: false
    	t.integer	:user_id
    	t.string	:author,				null: false
    	t.string	:author_email,	null: false
    	t.string	:author_url
    	t.text		:content
    	t.string	:meta_keyword
    	t.string	:approved
    	t.integer	:parent_id
      t.timestamps 							null: false
    end
    add_index(:comments, :post_id)
    add_index(:comments, :user_id) 
  end

  def down
  	drop_table :comments
  end
end
