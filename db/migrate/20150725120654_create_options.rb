class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
    	t.string	:namespace,	null: false
    	t.string	:names,			null: false
    	t.string	:value
    	t.string	:default
      t.timestamps null: false
    end
  end
end
