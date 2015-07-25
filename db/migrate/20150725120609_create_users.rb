class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
    	t.string		:username,				null: false
    	t.string		:password_digest, null: false
    	t.string		:displayed_name
    	t.string		:bio
    	t.string		:avatar
    	t.string		:reset_password_token
    	t.datetime	:reset_password_send_at
    	t.integer		:sign_in_count
    	t.datetime	:current_sign_in_at
    	t.datetime	:last_sign_in_at
    	t.string		:current_sign_in_ip
    	t.string		:last_sign_in_ip

      t.timestamps 	null: false
    end
  end

  def down
  	drop_table :users
  end
end
