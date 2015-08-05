class FixTables < ActiveRecord::Migration
  
  def up
    add_column(:users, :public_email, :string)
    add_column(:users, :profile_visible, :boolean)
  	add_column(:users, :access_level,	:string)
  	add_column(:users, :email, :string,:null => false, :after => :username, :default => "" )
  	add_column(:posts, :type, :string)
    rename_column(:users, :displayed_name, :full_name)
  	rename_column(:posts, :author_id, :user_id)
    change_column(:comments, :author, :string, null: true)
    change_column(:comments, :author_email, :string, null: true)
    remove_column(:posts, :password_digest)
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
    add_column(:posts, :password_digest)
    change_column(:comments, :author, :string, null: false)
    change_column(:comments, :author_email, :string, null: false)
  	rename_column(:posts, :user_id,		:author_id)
  	rename_column(:users, :full_name,	:displayed_name)
    remove_column(:posts, :type)
  	remove_column(:users, :email)
		remove_column(:users, :access_level)
    remove_column(:users, :public_email)
    remove_column(:users, :profile_visible)
  end
end
