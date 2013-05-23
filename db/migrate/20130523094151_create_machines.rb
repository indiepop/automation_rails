class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.text :name
      t.text :ip
      t.text :credential
      t.integer :machine_type
      t.text :remark

      t.timestamps
    end
  end
end
