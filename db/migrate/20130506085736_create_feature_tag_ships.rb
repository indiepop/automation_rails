class CreateFeatureTagShips < ActiveRecord::Migration
  def change
    create_table :feature_tag_ships do |t|
      t.integer :feature_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
