class CreateSnmps < ActiveRecord::Migration
  def change
    create_table :snmps do |t|
      t.string :simulated_ip
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
