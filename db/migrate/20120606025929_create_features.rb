class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.text :name
      t.integer :type
      t.text :description
      t.integer :author
      t.text :remark

      t.timestamps
    end
  end
end
