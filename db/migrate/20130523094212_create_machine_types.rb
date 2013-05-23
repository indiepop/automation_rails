class CreateMachineTypes < ActiveRecord::Migration
  def change
    create_table :machine_types do |t|
      t.integer :machine_type_id
      t.string :name

      t.timestamps
    end
  end
end
