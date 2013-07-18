class CreateRoadrunners < ActiveRecord::Migration
  def change
    create_table :roadrunners do |t|
      t.text :name
      t.text :script
      t.text :description
      t.text :remark

      t.timestamps
    end
  end
end
