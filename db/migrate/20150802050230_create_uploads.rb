class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
    	t.string :file_file_name
    	t.string :file_content_type
    	t.string :title
      t.datetime :create_at
    end
  end
end
