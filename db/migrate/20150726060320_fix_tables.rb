class FixTables < ActiveRecord::Migration
  
  def up
  	add_column(:users, :access_level,	:string)
  	add_column(:users, :email, :string,:null => false, :after => :username, :default => "" )
  	rename_column(:users, :displayed_name, :full_name)
  	rename_column(:posts, :author_id, :user_id)
  	# -------------------------
  	create_table :posts_categories, :id => false do |t|
  		t.integer :post_id
  		t.integer	:category_id
  	end
  	add_index :posts_categories, [:post_id, :category_id]
  	#--------------------------
  end

  def down
  	drop_table :posts_categories
  	rename_column(:posts, :user_id,		:author_id)
  	rename_column(:users, :full_name,	:displayed_name)
  	remove_column(:users, :email)
		remove_column(:users, :access_level)
  end
end