class CreateSorts < ActiveRecord::Migration
  def change
    create_table :sorts do |t|
      t.string :name

#      t.timestamps
    end
  end
end
