class AddStatusToSnmp < ActiveRecord::Migration
  def change
    add_column :snmps, :status, :string ,default: 'off'

  end
end
