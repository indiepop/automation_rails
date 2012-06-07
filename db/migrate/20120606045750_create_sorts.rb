class CreateSorts < ActiveRecord::Migration
  def change
    create_table :sorts,:id=>false  do |t|
      t.integer :sort_id
      t.string :name

#      t.timestamps
    end
  end
end
